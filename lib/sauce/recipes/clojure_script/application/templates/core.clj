(ns <%= @name %>.core
  (:use compojure.core)
  (:require [compojure.handler :as handler]
            [compojure.route :as route]))

(defroutes app-routes
  "The `defroutes` macro defines a Ring handler function from a number of
   individual routes.  The request map is passed to each function in turn,
   until a non-nil response is returned."

  (GET "/" [] "<p>Hello from compojure</p>")

  ;; Serve resources on the classpath, root dir is `public` by default.
  (route/resources "/")

  (route/not-found "Page not found"))

;; site function create an handler suitable for a standard website,
;; adding a bunch of standard ring middleware to app-route:
(def handler
  "Creates a handler suitable for a standard website.
   Ref: http://weavejester.github.io/compojure/compojure.handler.html"
  (handler/site app-routes))
