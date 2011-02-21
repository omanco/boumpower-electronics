
(defun AtomsReport(f); / AtomType Family Atoms tmp1)
  (setq Atoms nil)
  (foreach x (atoms-family 1)
;  (print x)
  (setq tmp1 (read (strcat "(type-of " x ")"))) ; list for geting type
  (setq AtomType (if (= (length tmp1) 2)
     (eval tmp1)
     '<SPCL>))

;    (setq AtomType (if (= (substr x 1 1) "{")
;     'SPCL
;      (eval (read (strcat "(type " x ")"))) ; type of atom
;      ))
;    (print AtomType) (prin1 x)
    (setq Family (assoc AtomType Atoms))
;    (print "Family : ") (prin1 Family)
    (setq Atoms (if Family 
                   (subst (append Family (list x)) Family Atoms)
                   (cons (list AtomType x) Atoms)))
;     (print "Atoms => ") (prin1 atoms)
;    (read-line)
  )
  (foreach x Atoms
    (write-line "<TABLE WIDTH=\"100%\" BORDER=\"1\">" f) 
    (write-line "<CAPTION>" f)
    (setq tmp1 (VL-PRIN1-TO-STRING (car x)))
    (setq tmp1 (substr tmp1 2 (- (strlen tmp1) 2)))
    (write-line tmp1 f)
    (write-line "</CAPTION>" f)
    (foreach y (acad_strlsort (cdr x))
      (write-line "<TR>" f)
      (write-line "<TD>" f)
      (write-line y f)
      (write-line "</TD>" f)
      (write-line "<TD></TD>" f)
      (write-line "</TR>" f)
    )
    (write-line "</TABLE>" f)
  )
)

(defun C:ACADINFO( / f )
  (setq f (open "TestAcadInfo.htm" "w"))
    (write-line "<HTML>" f) 
    (write-line "<HEAD><TITLE>AutoCAD Debug Info</TITLE></HEAD>" f) 
    (write-line "<BODY>" f) 
    (AtomsReport f)
    (write-line "</BODY>" f) 
    (write-line "</HTML>" f) 
  (close f)
  (startapp "IEXPLORE.EXE" (findfile "TestAcadInfo.htm"))
)