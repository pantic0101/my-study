(ns joc.ch7.astar)

(defn hello [x]
  (println (str "Hello " x "!")))

(def world [[  1   1   1   1   1]
	    [999 999 999 999   1]
	    [  1   1   1   1   1]
	    [  1 999 999 999 999]
	    [  1   1   1   1   1]])


(defn neighbors
  ([size yx]
     (neighbors [[-1 0] [1 0] [0 -1] [0 1]] size yx))
  ([deltas size yx]
     (filter (fn [new-yx]
	       (every? #(< -1 % size) new-yx))
	     (map #(vec (map + yx %)) deltas))))

(defn estimate-cost [step-cost-est size y x]
  (* step-cost-est
     (- (+ size size) y x 2)))

(defn path-cost [node-cost cheapest-nbr]
  (+ node-cost
     (:cost cheapest-nbr 0)))

(defn total-cost [newcost step-cost size y x]
  (+ newcost
     (estimate-cost step-cost size y x)))

(defn min-by [f coll]
  (when (seq coll)
    (reduce (fn [min this]
	      (if (> (f min) (f this)) this min))
	    coll)))

;; start-yx : 시작 위치
;; step-est : 
;; cell-costs: 지도(각 셀은 비용을 의미한다.
(defn astar [start-yx step-est cell-costs]
  (let [size (count cell-costs)]
    (loop [steps 0
	   routes (vec (replicate size (vec (replicate size nil))))
	   work-todo (sorted-set [0 start-yx])]
      (if (empty? work-todo)
	[(peek (peek routes)) :steps steps]
	(let [[_ yx :as work-item] (first work-todo)
	      rest-work-todo (disj work-todo work-item)
	      nbr-yxs (neighbors size yx)
	      cheapest-nbr (min-by :cost (keep #(get-in routes %)
					       nbr-yxs))
	      newcost (path-cost (get-in cell-costs yx) cheapest-nbr)
	      oldcost (:cost (get-in routes yx))]
	  (if (and oldcost (>= newcost oldcost))
	    (recur (inc steps) routes rest-work-todo)
	    (recur (inc steps)
		   (assoc-in routes yx
			     {:cost newcost
			      :yxs (conj (:yxs cheapest-nbr [])
					 yx)})
		   (into rest-work-todo
		   	 (map (fn [w]
				(let [[y x] w]
				  [(total-cost newcost step-est size y x) w]))
			      nbr-yxs)))))))))

;; (astar [0 0] 900 world)
;; clojure.lang.LazySeq cannot be cast to java.lang.Comparable
