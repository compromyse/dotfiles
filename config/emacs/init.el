(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 '(package-selected-packages '(fzf kaolin-themes evil popper flycheck lsp-mode cmake-mode nix-mode)))

(global-flycheck-mode 1)
(add-hook 'python-mode-hook #'lsp-deferred)
(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)

(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
        "\\*Async-native-compile-log\\*"
        "\\*lsp-log\\*"
        help-mode
        compilation-mode))
(popper-mode 1)
(global-set-key (kbd "M-`") 'popper-toggle)
(global-set-key (kbd "C-`") 'popper-cycle)
(global-set-key (kbd "s-`") 'popper-toggle-type)

(setq evil-want-C-u-scroll t)
(setq evil-undo-system 'undo-redo)
(setq evil-emacs-state-modes nil)
(setq evil-insert-state-modes nil)
(setq evil-motion-state-modes nil)
(require 'evil)
(evil-mode 1)

(global-set-key (kbd "M-<") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "M->") 'tab-bar-switch-to-next-tab)
(global-set-key (kbd "M-t") 'tab-bar-new-tab)
(global-set-key (kbd "M-w") 'tab-bar-close-tab)
(setq tab-bar-close-button-show nil)
(setq tab-bar-tab-hints t)
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

(set-fontset-font t nil "UbuntuMono Nerd Font Mono" nil 'append)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq-default cursor-type 'bar)

(setq scroll-step 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(global-goto-address-mode 1)
(global-visual-line-mode 1)
(delete-selection-mode 1)
(save-place-mode 1)
(setq scroll-margin 5)
(setq display-line-numbers-type 'relative)

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
(global-set-key (kbd "M-a") 'eshell)
(global-set-key (kbd "M-c") 'comment-line)

(global-set-key (kbd "M-RET") 'compile)

(defun show-flycheck-errors (buffer _action)
  (let ((window (display-buffer-in-side-window
                 buffer '((side . bottom) (slot . 0) (window-height . 0.25) (window-width . 0.75)))))
    (select-window window)
    window))

(defun show-buffers (buffer _action)
  (let ((window (display-buffer-in-side-window
                 buffer '((side . bottom) (slot . 1) (window-height . 0.25) (window-width . 0.25)))))
    (select-window window)
    window))

(add-to-list 'display-buffer-alist
		'("^\\*Flycheck errors\\*$" . (show-flycheck-errors)))

(add-to-list 'display-buffer-alist
             '("^\\*Ibuffer\\*$" . (show-buffers)))

(global-set-key (kbd "M-e") 'flycheck-list-errors)
(global-set-key (kbd "M-z") 'ibuffer-list-buffers)

(setq ibuffer-mode-hook '(ibuffer-auto-mode))
(setq ibuffer-formats
      '((mark modified read-only locked " "
              (name 35 35 :left :elide))))

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'minibuffer-exit-hook
      #'(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(setq dired-listing-switches "-lah --group-directories-first")
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

(setq sentence-end-double-space nil)

(setq ring-bell-function 'ignore)

(global-display-line-numbers-mode 1)

(electric-pair-mode 1)

(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

(require 'kaolin-themes)
(load-theme 'kaolin-dark t)

(add-to-list 'load-path (concat user-emacs-directory "/modeline"))
(require 'simple-modeline)
(simple-modeline-mode)

(require 'fzf)
(setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll --no-unicode"
    fzf/executable "fzf"
    fzf/git-grep-args "-i --line-number %s"
    fzf/grep-command "rg --no-heading -nH"
    fzf/position-bottom t
    fzf/window-height 15)

(global-set-key (kbd "M-SPC") 'fzf-directory)
(global-set-key (kbd "M-f") 'fzf-grep)
