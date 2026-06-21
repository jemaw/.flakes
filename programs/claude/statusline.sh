#!/usr/bin/env bash
# Claude Code statusLine — mirrors fish prompt: git + » on the left,
# repo path far-right. No colors.
# Receives JSON on stdin from Claude Code.

input=$(cat)

# Abbreviate a path like fish's prompt_pwd:
#   $HOME -> ~, every parent component shortened to its first char (leading dot
#   kept for hidden dirs, e.g. .flakes -> .f), final component left intact.
abbrev_pwd() {
  local raw="$1"
  local p="${raw/#$HOME/\~}"
  IFS='/' read -ra parts <<< "$p"
  local n=${#parts[@]}
  if [[ $n -le 1 ]]; then
    printf '%s' "$p"
    return
  fi
  local out="" i seg
  for (( i=0; i<n-1; i++ )); do
    seg="${parts[$i]}"
    if [[ -z "$seg" ]]; then
      out+="/"
    elif [[ "$seg" == "~" ]]; then
      out+="~/"
    elif [[ "$seg" == .* ]]; then
      out+="${seg:0:2}/"
    else
      out+="${seg:0:1}/"
    fi
  done
  out+="${parts[$n-1]}"
  printf '%s' "$out"
}

# --- extract fields ---------------------------------------------------------
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# --- git info ---------------------------------------------------------------
git_branch="" markers=""
if [[ -n "$cwd" ]]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    git_branch="$branch"
    porcelain=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    # dirty (unstaged) -> ! , staged -> + , ordered as fish does: !+
    echo "$porcelain" | grep -qP '^.[MD]'    && markers+="!"
    echo "$porcelain" | grep -qP '^[MADRCU]' && markers+="+"
  fi
fi

# --- build left segment -----------------------------------------------------
if [[ -n "$git_branch" ]]; then
  left="${git_branch}${markers} »"
else
  left="»"
fi
[[ -n "$model" ]] && left+="  ${model}"
if [[ -n "$remaining" ]]; then
  printf -v pct '%.0f' "$remaining"
  left+="  ctx:${pct}%"
fi

# --- build right segment ----------------------------------------------------
right=$(abbrev_pwd "$cwd")

# --- right-align: pad between left and right to terminal width ---------------
width="${COLUMNS:-}"
[[ -z "$width" ]] && width=$(tput cols </dev/tty 2>/dev/null)
[[ -z "$width" ]] && width=80
pad=$(( width - ${#left} - ${#right} ))
(( pad < 1 )) && pad=1

printf '%s%*s%s' "$left" "$pad" "" "$right"
