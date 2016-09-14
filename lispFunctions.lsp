;Danae Sánchez Villegas
;136040

;Reverse a Profundidad
;Deep Reverse

;functions
(defun reverprof(lista)
(setq alreves nil)
(revprof1 lista nil)
(print alreves out.txt)
)

(defun revprof1(lst r)
((null lst)(setq aux r)(setq alreves r ))
((atom (car lst))  (push (car lst) r)(revprof1 (cdr lst) r))
(setq aux nil) (revprof1 (car lst) aux)(push aux r)(revprof1(cdr lst) r)
)

;main
(open-output-file out.txt 'overwrite)
(reverprof '(1 (2 3 (9 8)) 5 (6 10)))
(close-output-file out.txt)
(system)

;Grado de un árbol
;Tree Degree

;Functions
(defun grado(arbol)
(setq res 0)
(grado1 (cdr arbol) 0)
(print res out.txt)
)

(defun grado1 (lst r)
((null lst) 
	((> r res)(setq res r)))	
((atom (car lst))(incq r)(grado1(cdr lst) r))
(grado1(car lst) 0) (grado1(cdr lst) r)
	
)

;main
(open-output-file out.txt 'overwrite)
(grado '(a (b(e f g)c(h i (o))d e)))
(close-output-file out.txt)
(system)


;Altura de un árbol
;Tree height

;functions
(defun alturaArbol(arbol)
(setq maxa 0 ind 0)
(altura arbol)
(print maxa out.txt)
)

(defun altura (arbol)
((null arbol) (decq ind))
((atom (car arbol))(altura(cdr arbol)))
(incq ind)
((> ind maxa)(setq maxa ind)(altura(car arbol))(altura(cdr arbol)))
(altura(car arbol))(altura(cdr arbol))
)

;main
(open-output-file out.txt 'overwrite)
(alturaArbol '(a (b(e f g)c(h i (o))d e)))
(close-output-file out.txt)
(system)

;Imprime por Niveles
;Printing by tree level

;functions

;main function
(defun impXNiv(arbol)
(setq ind 0 R nil maxa 0 niv 0)
(altura arbol)
(recorreNiv arbol)
(impXNiv1 R)
)

;tree height
(defun altura (arbol)
((null arbol) (decq ind))
((atom (car arbol))(altura(cdr arbol)))
(incq ind)
((> ind maxa)(setq maxa ind)(altura(car arbol))(altura(cdr arbol)))
(altura(car arbol))(altura(cdr arbol))

)


;Level indicator function
(defun indicaNivel(arbol)
((null arbol)(decq ind))
((atom (car arbol))
	((eql ind niv)(push (list (car arbol) niv) R)(indicaNivel (cdr arbol)))
	(indicaNivel(cdr arbol)))
(incq ind)(indicaNivel (car arbol)) (indicaNivel (cdr arbol))
)

;iterate by tree level
(defun recorreNiv(arbol)
((> niv maxa)(setq R (reverse R)))
(setq ind 0)
(indicaNivel arbol)
(incq niv)
(recorreNiv arbol)
)

;hyphen printing function
(defun impGuiones(num)
((or (eql num 0)(eql num 1))(prin1 _ out.txt))
(prin1 _ out.txt)(spaces 1)(decq num)(impGuiones num)
)

;printing the nodes and the hyphens
(defun impXNiv1(lst)
((null lst))
(impGuiones (cadar lst))(prin1 (caar lst) out.txt)(spaces 1)(impXNiv1 (cdr lst))

)

;main
(open-output-file out.txt 'overwrite)
(impXNiv '(a (b(e f g)c(h i (o))d e)))
(close-output-file out.txt)
(system)
