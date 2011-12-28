;;; ロードパスの追加
(setq load-path (append
                 '("~/.emacs.d"
                   "~/.emacs.d/elisp"
                   "~/.emacs.d/auto-install"
                   "~/.emacs.d/elisp/ruby")
                 load-path))

;;; 入力
(setq default-input-method "MacOSX")

;;-----------------------------------------------------------------
;; language
;;-----------------------------------------------------------------
(set-language-environment 'Japanese)
(set-terminal-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq coding-system-for-read 'mule-utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)

;;; フォント
(set-face-attribute 'default nil
                   :family "Ricty"
                   :height 160)
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; ComanndキーをMetaに
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;;; ドラッグオンドロップ
(define-key global-map [ns-drag-file] 'ns-find-file)

;;;;;;;;;;

;;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保

;;; --------------------
;;; Ruby
;;; --------------------

;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; rubydb
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;;; --------------------
;;; Git
;;; --------------------
(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require 'git)
(autoload 'git-blame-mode "git-blame"
           "Minor mode for incremental blame for Git." t)

(define-key global-map "\C-x\C-g" 'git-status)

(setq git--repository-bookmarks
      '("git://github.com/xcezx/scratch.git"
        "git://github.com/xcezx/dotfiles.git"))
