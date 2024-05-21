(atx_heading
  [(atx_h1_marker) (atx_h2_marker) (atx_h3_marker) (atx_h4_marker) (atx_h5_marker) (atx_h6_marker)] @level
  heading_content: (_) @name
  (#set! "kind" "Interface")
  ) @symbol

; (atx_heading ...) @symbol: ATX形式ヘディング（#, ##, ###, など）全体をキャプチャし、@symbolとしてタグ付け。
; [(atx_h1_marker) (atx_h2_marker) (atx_h3_marker) (atx_h4_marker) (atx_h5_marker) (atx_h6_marker)] @level: 各ヘディングレベルのマーカー（#～######）をキャプチャし、@levelとしてタグ付け。
; heading_content: (_) @name: ヘディングの内容部分をキャプチャし、@nameとしてタグ付け。
; (#set! "kind" "Interface"): このキャプチャされたシンボルの種類を Interface に設定。

(list
  (list_item
    (list_marker_minus)
    (task_list_marker_checked) @level
    (paragraph 
      (inline (_) @name)
    )
  (#set! "kind" "Class")
  )
) @symbol


; (setext_heading
;   heading_content: (_) @name
;   (#set! "kind" "Interface")
;   [(setext_h1_underline) (setext_h2_underline)] @level
;   ) @symbol
; (list
;   (list_item
;     (list_marker_minus)
;     (task_list_marker_checked) @level
;     ; (paragraph 
;     ;   (inline (_) @name)
;     ; )
;   (#set! "kind" "Class")
;   )
; ) @symbol
;
; (list
;   (list_item
;     (list_marker_minus)
;     (task_list_marker_unchecked) @level
;     ; (paragraph 
;     ;   (inline (_) @name)
;     ; )
;   (#set! "kind" "Class")
;   )
; ) @symbol
