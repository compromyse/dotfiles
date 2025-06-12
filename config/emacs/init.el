(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 '(package-selected-packages '(fzf kaolin-themes evil evil-collection popper corfu direnv magit ccls clang-format make-mode nix-mode vue-mode typescript-mode haml-mode yaml-mode)))

(set-fontset-font t nil "UbuntuMono Nerd Font Mono" nil 'append)

(require 'kaolin-themes)
(load-theme 'kaolin-dark t)

(add-to-list 'load-path (concat user-emacs-directory "/modeline"))
(require 'simple-modeline)
(simple-modeline-mode)

(setq-default c-basic-offset 2)
(setq-default cursor-type 'bar)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(setq auto-save-default nil)
(setq compilation-scroll-output t)
(setq dired-listing-switches "-lah --group-directories-first")
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq display-line-numbers-type 'relative)
(setq make-backup-files nil)
(setq ring-bell-function 'ignore)
(setq scroll-margin 5)
(setq scroll-step 1)
(setq sentence-end-double-space nil)
(setq tab-bar-close-button-show nil)
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
(setq tab-bar-tab-hints t)

(fset 'yes-or-no-p 'y-or-n-p)

(blink-cursor-mode -1)
(delete-selection-mode 1)
(global-goto-address-mode 1)
(global-visual-line-mode 1)
(menu-bar-mode -1)
(save-place-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(require 'direnv)
(direnv-mode 1)

(setq evil-emacs-state-modes nil)
(setq evil-insert-state-modes nil)
(setq evil-motion-state-modes nil)
(setq evil-undo-system 'undo-redo)
(setq evil-want-C-u-scroll t)
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(evil-collection-init)

(setq corfu-auto t)
(global-corfu-mode)

(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*compilation\\*"
        "\\*Async Shell Command\\*"
        "\\*Async-native-compile-log\\*"
        help-mode))
(popper-mode 1)

(add-hook 'minibuffer-exit-hook
      #'(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

(global-display-line-numbers-mode 1)

(electric-pair-mode 1)

(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

(require 'fzf)
(setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll --no-unicode"
    fzf/executable "fzf"
    fzf/git-grep-args "-i --line-number %s"
    fzf/grep-command "rg --no-heading -nH"
    fzf/position-bottom t
    fzf/window-height 15)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(add-hook 'before-save-hook 'eglot-format)

(global-set-key (kbd "s-`") 'popper-toggle)
(global-set-key (kbd "C-`") 'popper-cycle)
(global-set-key (kbd "M-`") 'popper-toggle-type)

(global-set-key (kbd "M-<") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "M->") 'tab-bar-switch-to-next-tab)
(global-set-key (kbd "M-t") 'tab-bar-new-tab)
(global-set-key (kbd "M-w") 'tab-bar-close-tab)

(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-l") 'windmove-right)

(global-set-key (kbd "M--") 'split-window-below)
(global-set-key (kbd "M-\\") 'split-window-right)
(global-set-key (kbd "M-d") 'dired-jump)
(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-[") 'previous-buffer)
(global-set-key (kbd "M-k") 'kill-buffer)
(global-set-key (kbd "M-q") 'delete-window)
(global-set-key (kbd "M-c") 'comment-line)
(global-set-key (kbd "M-RET") 'project-compile)
(global-set-key (kbd "C-SPC") 'fzf-git)
(global-set-key (kbd "M-f") 'fzf-git-grep)
