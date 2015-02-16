;; 逆ポーランド記法電卓 (関数型スタイル)

(ns rpn-calculator
  (:require [clojure.string :refer [split]]))

(declare ope-fn)

(def ^:private operators
  {"+" +
   "-" -
   "*" *
   "/" /})

(defn calculate [rpn]
  (let [calc (fn [stack [x & xs :as expr]]
               (if (empty? expr)
                 (first stack)
                 (cond
                   (every? #(Character/isDigit %) x)
                     (recur (cons (Double/parseDouble x) stack) xs)
                   (>= (count stack) 2)
                     (let [[y1 y2 & ys] stack]
                       (recur (cons ((ope-fn x) y2 y1) ys) xs))
                   :else
                     (throw (IllegalArgumentException. "unexpected pattern found")))))
        expr (split rpn #"\s+")]
    (calc () expr)))

(defn- ope-fn [ope]
  (if (contains? operators ope)
    (operators ope)
    (throw (IllegalArgumentException.
      (format "unsupported operator '%s' is used" ope)))))

;; 利用例
(let [rpn "1 2 + 3 / 4 - 5 *"]
  (printf "%s%n = %s%n" rpn (calculate rpn)))
