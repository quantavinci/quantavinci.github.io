;; -*- lexical-binding: t -*-
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(package-install 'htmlize)

(require 'ox-publish)

(setq org-publish-project-alist
      '(

        ;; 1) Publish Org → HTML
        ("blog-org"
         :base-directory    "content"
         :base-extension    "org"
         :recursive         t
         :auto-sitemap      t
         :sitemap-filename  "index.org"
         :sitemap-title     "Posts"
         :publishing-directory "public"
         :publishing-function  org-html-publish-to-html
         :with-toc             t
         :section-numbers      nil
         :with-author          nil
         :with-creator         nil
         ;; **relative** link: no leading slash
         :html-head
         "<link rel=\"stylesheet\" href=\"static/css/neon.css\"/>\n\
<script src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>")

        ;; 2) Copy static assets
        ("blog-static"
         :base-directory       "static"
         :base-extension       "css\\|png\\|jpg\\|svg"
         :recursive            t
         :publishing-directory "public/static"
         :publishing-function  org-publish-attachment)

        ;; 3) Composite project
        ("blog" :components ("blog-org" "blog-static"))
        ))

;; Build all projects
(org-publish-all t)
(message "Build complete")
