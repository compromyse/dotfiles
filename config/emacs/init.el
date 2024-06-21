(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 '(package-selected-packages '(fzf kaolin-themes evil flycheck lsp-mode cmake-mode)))

(global-flycheck-mode 1)
(add-hook 'python-mode-hook #'lsp-deferred)
(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)

(setq evil-want-C-u-scroll t)
(setq evil-undo-system 'undo-redo)
(require 'evil)
(evil-mode 1)

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

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-z") 'ibuffer)
(global-set-key (kbd "M-d") 'dired-jump)
(global-set-key (kbd "M-k") 'kill-buffer)
(global-set-key (kbd "M-t") 'eshell)
(global-set-key (kbd "M-c") 'comment-line)

(global-set-key (kbd "M-RET") 'compile)

(defun display-flycheck-errors-bottom (buffer _action)
  (let ((window (display-buffer-in-side-window
                 buffer '((side . bottom) (slot . 0) (window-height . 0.25)))))
    (select-window window)
    window))

(add-to-list 'display-buffer-alist
             '("^\\*Flycheck errors\\*$" . (display-flycheck-errors-bottom)))

(global-set-key (kbd "M-e") 'flycheck-list-errors)

(fset 'yes-or-no-p 'y-or-n-p)

(setq initial-scratch-message "")
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

(defun remove-native-compile-buffer ()
  (if (get-buffer "*Async-native-compile-log*")
      (kill-buffer "*Async-native-compile-log*")))
(add-hook 'after-change-major-mode-hook 'remove-native-compile-buffer)

(setq-default message-log-max nil)
(kill-buffer "*Messages*")

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

(global-set-key (kbd "C-SPC") 'fzf-directory)
