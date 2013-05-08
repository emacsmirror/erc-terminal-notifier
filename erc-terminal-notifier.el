;;; erc-terminal-notifier.el --- OSX notifications via the terminal-notifier gem for Emacs ERC.

;; Copyright (c) 2013 Julien Blanchard <julien@sideburns.eu>

;; Author: Julien Blanchard <julien@sideburns.eu>
;; URL: http://github.com/julienXX/
;; Keywords: erc terminal-notifier nick
;; Created: 08 May 2013
;; Version: 0.1

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; OSX notifications via the terminal-notifier gem for Emacs ERC.
;;

;;; Install

;; $ cd ~/.emacs.d/vendor
;; $ git clone git://github.com/julienXX/erc-terminal-notifier.el.git
;;
;; In your emacs config:
;;
;; (add-to-list 'load-path "~/.emacs.d/vendor/erc-terminal-notifier.el")
;; (require 'erc-terminal-notifier)

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
;;;###autoload
(defvar erc-terminal-notifier-command (executable-find "terminal-notifier") "The path to terminal-notifier.")

(defun erc-terminal-notifier-notify (title message)
  "Show a message with `terminal-notifier-command`."
  (start-process "terminal-notifier"
                 "*terminal-notifier*"
                 erc-terminal-notifier-command
                 "-title" title
                 "-message" message
                 "-activate" "org.gnu.Emacs"))

(defun erc-terminal-notifier-hook (match-type nick message)
  "Show a notification, when user's nick is mentioned."
  (when (eq match-type 'current-nick)
    (unless (posix-string-match "^\\** *Users on #" message)
      (erc-terminal-notifier-notify
       (concat "ERC " (buffer-name (current-buffer)))
       message))))

(if (eq system-type 'darwin)
    (add-hook 'erc-text-matched-hook 'erc-terminal-notifier-hook))

(provide 'erc-terminal-notifier)
;;; erc-terminal-notifier.el ends here
