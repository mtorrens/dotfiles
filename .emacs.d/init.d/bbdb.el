
;; BBDB
(add-to-list 'load-path "~/.emacs.d/packages/bbdb-2.35")

(require 'bbdb-autoloads)
(bbdb-initialize)
(bbdb-insinuate-w3)

(setq bbdb-file "~/Dropbox/Charles/Personal/Addresses"
      bbdb-default-country "USA"
      bbdb-default-area-code nil
      bbdb-offer-save 1
      bbdb-use-pop-up nil
      bbdb-always-add-address nil
      bbdb/mail-auto-create-p nil
      bbdb/news-auto-create-p nil
      bbdb-completion-type nil
      bbdb-complete-name-allow-cycling t
      bbdb-message-caching-enabled t
      bbdb-use-alternate-names t
      bbdb-elided-display t)
