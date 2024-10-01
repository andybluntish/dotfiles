function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  set -l normal (set_color normal)
  set -l status_color (set_color brgreen)
  set -l cwd_color (set_color $fish_color_cwd)
  set -l vcs_color (set_color brpurple)
  set -l prompt_status ""

  # More informative VCS
  if not set -q __fish_git_prompt_show_informative_status
    set -g __fish_git_prompt_show_informative_status 1
  end
  if not set -q __fish_git_prompt_hide_untrackedfiles
    set -g __fish_git_prompt_hide_untrackedfiles 1
  end
  if not set -q __fish_git_prompt_color_branch
    set -g __fish_git_prompt_color_branch magenta --bold
  end
  if not set -q __fish_git_prompt_showupstream
    set -g __fish_git_prompt_showupstream informative
  end
  if not set -q __fish_git_prompt_color_dirtystate
    set -g __fish_git_prompt_color_dirtystate blue
  end
  if not set -q __fish_git_prompt_color_stagedstate
    set -g __fish_git_prompt_color_stagedstate yellow
  end
  if not set -q __fish_git_prompt_color_invalidstate
    set -g __fish_git_prompt_color_invalidstate red
  end
  if not set -q __fish_git_prompt_color_untrackedfiles
    set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
  end
  if not set -q __fish_git_prompt_color_cleanstate
    set -g __fish_git_prompt_color_cleanstate green --bold
  end

  # Since we display the prompt on a new line allow the directory names to be longer.
  set -q fish_prompt_pwd_dir_length
  or set -lx fish_prompt_pwd_dir_length 0

  # Color the prompt differently when we're root
  set -l suffix '❯'
  if functions -q fish_is_root_user; and fish_is_root_user
    if set -q fish_color_cwd_root
      set cwd_color (set_color $fish_color_cwd_root)
    end
    set suffix '#'
  end

  # Color the prompt in red on error
  if test $last_status -ne 0
    set status_color (set_color $fish_color_error)
    set prompt_status $status_color "[" $last_status "]" $normal
  end

  #echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
  echo -s $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
  echo -n -s $status_color $suffix ' ' $normal
end
