(ns server.core.lov
  (:require
    [clojure.tools.logging :refer (info warn error debug)]
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    [clj-http.client :as client]
    )
  )

(defn listen! [lov]
  (go-loop []
    (let [v (<! @(:mom-adapter lov))]
      (if v (swap! (:recommender lov) 
        (fn [m] 
          (let [payload (dissoc v :topic)
                _key (first (keys payload))
                _val (get payload _key)]
            (assoc m _key _val)
            )
          )
        ))
      )
    (recur)
    )
  )

(def recommend (memoize (fn [entity]
  (let [result (:body (client/get (str "http://lov.okfn.org/dataset/lov/api/v1/search?q=" entity)))]
    {entity result}
    )
  )))

(defn update-recommender! [lov entity]
  (go
    (let [result (recommend entity)]
      (>! @(:mom-adapter lov) result) 
      )
    )
  )
