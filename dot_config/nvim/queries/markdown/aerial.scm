(list_item
  (list_marker_minus)
  (task_list_marker_checked) @symbol
  (paragraph
    (inline (_) @name)
  )
  (block_continuation)
(#set! "kind" "Interface")
) @symbol

(atx_heading
  [(atx_h1_marker) (atx_h2_marker) (atx_h3_marker) (atx_h4_marker) (atx_h5_marker) (atx_h6_marker)] @level
  ;heading_content: (_) @name
  (#set! "kind" "Class")
  ) @symbol

(setext_heading
  heading_content: (_) @name
  (#set! "kind" "Interface")
  [(setext_h1_underline) (setext_h2_underline)] @level
  ) @symbol



  ; (export_statement ; [8, 0] - [113, 1]
  ;   declaration: (class_declaration ; [8, 7] - [113, 1]
  ;     name: (type_identifier) ; [8, 13] - [8, 19]
  ;     (class_heritage ; [8, 20] - [8, 38]
  ;       (extends_clause ; [8, 20] - [8, 38]
  ;         value: (identifier))) ; [8, 28] - [8, 38]

;; TS
; (class_declaration
;   name: (type_identifier) @name
;   (#set! "kind" "Class")
;   ) @symbol

; (document ; [0, 0] - [12, 0]
;   (section ; [0, 0] - [12, 0]
;     (atx_heading ; [0, 0] - [1, 0]
;       (atx_h1_marker) ; [0, 0] - [0, 1]
;       heading_content: (inline ; [0, 2] - [0, 10]
;         (inline))) ; [0, 2] - [0, 10]
;     (paragraph ; [1, 0] - [6, 0]
;       (inline ; [1, 0] - [5, 105]
;         (inline ; [1, 0] - [5, 105]
;           (inline_link ; [1, 32] - [1, 77]
;             (link_text) ; [1, 33] - [1, 40]
;             (link_destination)) ; [1, 42] - [1, 76]
;           (shortcut_link ; [3, 0] - [3, 97]
;             (link_text))))) ; [3, 1] - [3, 96]
;     (section ; [6, 0] - [11, 0]
;       (atx_heading ; [6, 0] - [7, 0]
;         (atx_h2_marker) ; [6, 0] - [6, 2]
;         heading_content: (inline ; [6, 3] - [6, 4]
;           (inline))) ; [6, 3] - [6, 4]
;       (list ; [7, 0] - [11, 0]
;         (list_item ; [7, 0] - [10, 0]
;           (list_marker_minus) ; [7, 0] - [7, 2]
;           (task_list_marker_unchecked) ; [7, 2] - [7, 5]
;           (paragraph ; [7, 6] - [8, 2]
;             (inline ; [7, 6] - [7, 10]
;               (inline)) ; [7, 6] - [7, 10]
;             (block_continuation)) ; [8, 0] - [8, 2]
;           (list ; [8, 2] - [10, 0]
;             (list_item ; [8, 2] - [9, 2]
;               (list_marker_minus) ; [8, 2] - [8, 4]
;               (task_list_marker_unchecked) ; [8, 4] - [8, 7]
;               (paragraph ; [8, 8] - [9, 2]
;                 (inline ; [8, 8] - [8, 11]
;                   (inline)) ; [8, 8] - [8, 11]
;                 (block_continuation))) ; [9, 0] - [9, 2]
;             (list_item ; [9, 2] - [10, 0]
;               (list_marker_minus) ; [9, 2] - [9, 4]
;               (task_list_marker_checked) ; [9, 4] - [9, 7]
;               (paragraph ; [9, 8] - [10, 0]
;                 (inline ; [9, 8] - [9, 10]
;                   (inline)))))) ; [9, 8] - [9, 10]
;         (list_item ; [10, 0] - [11, 0]
;           (list_marker_minus) ; [10, 0] - [10, 2]
;           (task_list_marker_checked) ; [10, 2] - [10, 5]
;           (paragraph ; [10, 6] - [11, 0]
;             (inline ; [10, 6] - [10, 10]
;               (inline)))))) ; [10, 6] - [10, 10]
;     (section ; [11, 0] - [12, 0]
;       (atx_heading ; [11, 0] - [12, 0]
;         (atx_h2_marker) ; [11, 0] - [11, 2]
;         heading_content: (inline ; [11, 3] - [11, 4]
;           (inline)))))) ; [11, 3] - [11, 4]
