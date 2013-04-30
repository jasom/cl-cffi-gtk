;;; ----------------------------------------------------------------------------
;;; gtk.text-buffer.lisp
;;;
;;; This file contains code from a fork of cl-gtk2.
;;; See <http://common-lisp.net/project/cl-gtk2/>.
;;;
;;; The documentation has been copied from the GTK+ 3 Reference Manual
;;; Version 3.6.4. See <http://www.gtk.org>. The API documentation of the
;;; Lisp binding is available at <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2013 Dieter Kaiser
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU Lesser General Public License for Lisp
;;; as published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version and with a preamble to
;;; the GNU Lesser General Public License that clarifies the terms for use
;;; with Lisp programs and is referred as the LLGPL.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this program and the preamble to the Gnu Lesser
;;; General Public License.  If not, see <http://www.gnu.org/licenses/>
;;; and <http://opensource.franz.com/preamble.html>.
;;; ----------------------------------------------------------------------------
;;;
;;; GtkTextBuffer
;;; 
;;; Stores attributed text for display in a GtkTextView
;;;     
;;; Synopsis
;;; 
;;;     GtkTextBuffer
;;;     
;;;     gtk_text_buffer_new
;;;     gtk_text_buffer_get_line_count
;;;     gtk_text_buffer_get_char_count
;;;     gtk_text_buffer_get_tag_table
;;;     gtk_text_buffer_insert
;;;     gtk_text_buffer_insert_at_cursor
;;;     gtk_text_buffer_insert_interactive
;;;     gtk_text_buffer_insert_interactive_at_cursor
;;;     gtk_text_buffer_insert_range
;;;     gtk_text_buffer_insert_range_interactive
;;;     gtk_text_buffer_insert_with_tags
;;;     gtk_text_buffer_insert_with_tags_by_name
;;;     gtk_text_buffer_delete
;;;     gtk_text_buffer_delete_interactive
;;;     gtk_text_buffer_backspace
;;;     gtk_text_buffer_set_text
;;;     gtk_text_buffer_get_text
;;;     gtk_text_buffer_get_slice
;;;     gtk_text_buffer_insert_pixbuf
;;;     gtk_text_buffer_insert_child_anchor
;;;     gtk_text_buffer_create_child_anchor
;;;     gtk_text_buffer_create_mark
;;;     gtk_text_buffer_move_mark
;;;     gtk_text_buffer_move_mark_by_name
;;;     gtk_text_buffer_add_mark
;;;     gtk_text_buffer_delete_mark
;;;     gtk_text_buffer_delete_mark_by_name
;;;     gtk_text_buffer_get_mark
;;;     gtk_text_buffer_get_insert
;;;     gtk_text_buffer_get_selection_bound
;;;     gtk_text_buffer_get_has_selection
;;;     gtk_text_buffer_place_cursor
;;;     gtk_text_buffer_select_range
;;;     gtk_text_buffer_apply_tag
;;;     gtk_text_buffer_remove_tag
;;;     gtk_text_buffer_apply_tag_by_name
;;;     gtk_text_buffer_remove_tag_by_name
;;;     gtk_text_buffer_remove_all_tags
;;;     gtk_text_buffer_create_tag
;;;     gtk_text_buffer_get_iter_at_line_offset
;;;     gtk_text_buffer_get_iter_at_offset
;;;     gtk_text_buffer_get_iter_at_line
;;;     gtk_text_buffer_get_iter_at_line_index
;;;     gtk_text_buffer_get_iter_at_mark
;;;     gtk_text_buffer_get_iter_at_child_anchor
;;;     gtk_text_buffer_get_start_iter
;;;     gtk_text_buffer_get_end_iter
;;;     gtk_text_buffer_get_bounds
;;;     gtk_text_buffer_get_modified
;;;     gtk_text_buffer_set_modified
;;;     gtk_text_buffer_delete_selection
;;;     gtk_text_buffer_paste_clipboard
;;;     gtk_text_buffer_copy_clipboard
;;;     gtk_text_buffer_cut_clipboard
;;;     gtk_text_buffer_get_selection_bounds
;;;     gtk_text_buffer_begin_user_action
;;;     gtk_text_buffer_end_user_action
;;;     gtk_text_buffer_add_selection_clipboard
;;;     gtk_text_buffer_remove_selection_clipboard
;;;     
;;;     GtkTextBufferTargetInfo
;;;     
;;;     gtk_text_buffer_deserialize
;;;     gtk_text_buffer_deserialize_get_can_create_tags
;;;     gtk_text_buffer_deserialize_set_can_create_tags
;;;     gtk_text_buffer_get_copy_target_list
;;;     gtk_text_buffer_get_deserialize_formats
;;;     gtk_text_buffer_get_paste_target_list
;;;     gtk_text_buffer_get_serialize_formats
;;;     gtk_text_buffer_register_deserialize_format
;;;     gtk_text_buffer_register_deserialize_tagset
;;;     gtk_text_buffer_register_serialize_format
;;;     gtk_text_buffer_register_serialize_tagset
;;;     gtk_text_buffer_serialize
;;;     gtk_text_buffer_unregister_deserialize_format
;;;     gtk_text_buffer_unregister_serialize_format
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; GtkTextBuffer
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkTextBuffer" gtk-text-buffer
  (:superclass g-object
    :export t
    :interfaces nil
    :type-initializer "gtk_text_buffer_get_type")
  ((copy-target-list
    gtk-text-buffer-copy-target-list
    "copy-target-list" "GtkTargetList" t nil)
   (cursor-position
    gtk-text-buffer-cursor-position
    "cursor-position" "gint" t nil)
   (has-selection
    gtk-text-buffer-has-selection
    "has-selection" "gboolean" t nil)
   (paste-target-list
    gtk-text-buffer-paste-target-list
    "paste-target-list" "GtkTargetList" t nil)
   (tag-table
    gtk-text-buffer-tag-table
    "tag-table" "GtkTextTagTable" t nil)
   (text
    gtk-text-buffer-text
    "text" "gchararray" t t)))

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation 'gtk-text-buffer 'type)
 "@version{2013-4-29}
  @begin{short}
    You may wish to begin by reading the text widget conceptual overview which
    gives an overview of all the objects and data types related to the text
    widget and how they work together.
  @end{short}
  @begin[Signal Details]{dictionary}
    @subheading{The \"apply-tag\" signal}
      @begin{pre}
 lambda (textbuffer tag start end)   : Run Last
      @end{pre}
      The \"apply-tag\" signal is emitted to apply a tag to a range of text in a
      @sym{gtk-text-buffer} object. Applying actually occurs in the default
      handler.
      Note that if your handler runs before the default handler it must not
      invalidate the start and end iters (or has to revalidate them).
      See also:
      @fun{gtk-text-buffer-apply-tag},
      @fun{gtk-text-buffer-insert-with-tags},
      @fun{gtk-text-buffer-insert-range}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[tag]{the applied tag}
        @entry[start]{the start of the range the tag is applied to}
        @entry[end]{the end of the range the tag is applied to}
      @end{table}@br{}
    @subheading{The \"begin-user-action\" signal}
      @begin{pre}
 lambda (textbuffer)   : Run Last
      @end{pre}
      The \"begin-user-action\" signal is emitted at the beginning of a single
      user-visible operation on a @sym{gtk-text-buffer}.
      See also:
      @fun{gtk-text-buffer-begin-user-action},
      @fun{gtk-text-buffer-insert-interactive},
      @fun{gtk-text-buffer-insert-range-interactive},
      @fun{gtk-text-buffer-delete-interactive},
      @fun{gtk-text-buffer-backspace},
      @fun{gtk-text-buffer-delete-selection}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
      @end{table}@br{}
    @subheading{The \"changed\" signal}
      @begin{pre}
 lambda (textbuffer)
      @end{pre}
      The \"changed signal\" is emitted when the content of a GtkTextBuffer has
      changed.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
      @end{table}@br{}
    @subheading{The \"delete-range\" signal}
      @begin{pre}
 lambda (textbuffer start end)   : Run Last
      @end{pre}
      The \"delete-range\" signal is emitted to delete a range from a
      @sym{gtk-text-buffer}.
      Note that if your handler runs before the default handler it must not
      invalidate the start and end iters (or has to revalidate them). The
      default signal handler revalidates the start and end iters to both point
      point to the location where text was deleted. Handlers which run after the
      default handler (see @fun{g-signal-connect-after}) do not have access to
      the deleted text.
      See also: @fun{gtk-text-buffer-delete}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[start]{the start of the range to be deleted}
        @entry[end]{the end of the range to be deleted}
      @end{table}@br{}
    @subheading{The \"end-user-action\" signal}
      @begin{pre}
 lambda (textbuffer)   : Run Last
      @end{pre}
      The \"end-user-action\" signal is emitted at the end of a single
      user-visible operation on the @sym{gtk-text-buffer}.
      See also:
      @fun{gtk-text-buffer-end-user-action},
      @fun{gtk-text-buffer-insert-interactive},
      @fun{gtk-text-buffer-insert-range-interactive},
      @fun{gtk-text-buffer-delete-interactive},
      @fun{gtk-text-buffer-backspace},
      @fun{gtk-text-buffer-delete-selection},
      @fun{gtk-text-buffer-backspace}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
      @end{table}@br{}
    @subheading{The \"insert-child-anchor\" signal}
      @begin{pre}
 lambda (textbuffer location anchor)   : Run Last
      @end{pre}
      The \"insert-child-anchor\" signal is emitted to insert a
      @class{gtk-text-child-anchor} in a @sym{gtk-text-buffer}. Insertion
      actually occurs in the default handler.
      Note that if your handler runs before the default handler it must not
      invalidate the location iter (or has to revalidate it). The default signal
      handler revalidates it to be placed after the inserted anchor.
      See also: @fun{gtk-text-buffer-insert-child-anchor}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[location]{position to insert anchor in textbuffer}
        @entry[anchor]{the @class{gtk-textchild-anchor} to be inserted}
      @end{table}@br{}
    @subheading{The \"insert-pixbuf\" signal}
      @begin{pre}
 lambda (textbuffer location pixbuf)   : Run Last
      @end{pre}
      The \"insert-pixbuf\" signal is emitted to insert a @class{gdk-pixbuf} in
      a @sym{gtk-text-buffer}. Insertion actually occurs in the default handler.
      Note that if your handler runs before the default handler it must not
      invalidate the location iter (or has to revalidate it). The default signal
      handler revalidates it to be placed after the inserted pixbuf.
      See also: @fun{gtk-text-buffer-insert-pixbuf}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[location]{position to insert pixbuf in textbuffer}
        @entry[pixbuf]{the @class{gdk-pixbuf} to be inserted}
      @end{table}@br{}
    @subheading{The \"insert-text\" signal}
      @begin{pre}
 lambda (textbuffer location text len)   : Run Last
      @end{pre}
      The \"insert-text\" signal is emitted to insert text in a
      @sym{gtk-text-buffer}.
      Insertion actually occurs in the default handler.
      Note that if your handler runs before the default handler it must not
      invalidate the location iter (or has to revalidate it). The default signal
      handler revalidates it to point to the end of the inserted text.
      See also:
      @fun{gtk-text-buffer-insert},
      @fun{gtk-text-buffer-insert-range}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[location]{position to insert text in textbuffer}
        @entry[text]{the UTF-8 text to be inserted}
        @entry[len]{length of the inserted text in bytes}
      @end{table}@br{}
    @subheading{The \"mark-deleted\" signal}
      @begin{pre}
 lambda (textbuffer mark)   : Run Last
      @end{pre}
      The \"mark-deleted\" signal is emitted as notification after a
      @class{gtk-text-mark} is deleted.
      See also: @fun{gtk-text-buffer-delete-mark}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[mark]{The mark that was deleted}
      @end{table}@br{}
    @subheading{The \"mark-set\" signal}
      @begin{pre}
 lambda (textbuffer location mark)   : Run Last
      @end{pre}
      The \"mark-set\" signal is emitted as notification after a
      @class{gtk-text-mark} is set.
      See also:
      @fun{gtk-text-buffer-create-mark},
      @fun{gtk-text-buffer-move-mark}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[location]{The location of mark in textbuffer}
        @entry[mark]{The mark that is set}
      @end{table}@br{}
    @subheading{The \"modified-changed\" signal}
      @begin{pre}
 lambda (textbuffer)   : Run Last
      @end{pre}
      The \"modified-changed\" signal is emitted when the modified bit of a
      @sym{gtk-text-buffer} flips.
      See also: @fun{gtk-text-buffer-set-modified}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
      @end{table}@br{}
    @subheading{The \"paste-done\" signal}
      @begin{pre}
 lambda (textbuffer clipboard)   : Run Last
      @end{pre}
      The paste-done signal is emitted after paste operation has been completed.
      This is useful to properly scroll the view to the end of the pasted text.
      See @fun{gtk-text-buffer-paste-clipboard} for more details.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
      @end{table}
      Since 2.16

    @subheading{The \"remove-tag\" signal}
      @begin{pre}
 lambda (textbuffer tag start end)   : Run Last
      @end{pre}
      The \"remove-tag\" signal is emitted to remove all occurrences of tag from
      a range of text in a @sym{gtk-text-buffer}. Removal actually occurs in the
      default handler.
      Note that if your handler runs before the default handler it must not
      invalidate the start and end iters (or has to revalidate them).
      See also: @fun{gtk-text-buffer-remove-tag}.
      @begin[code]{table}
        @entry[textbuffer]{the object which received the signal}
        @entry[tag]{the tag to be removed}
        @entry[start]{the start of the range the tag is removed from}
        @entry[end]{the end of the range the tag is removed from}
      @end{table}
  @end{dictionary}
  @see-slot{gtk-text-buffer-copy-target-list}
  @see-slot{gtk-text-buffer-cursor-position}
  @see-slot{gtk-text-buffer-has-selection}
  @see-slot{gtk-text-buffer-paste-target-list}
  @see-slot{gtk-text-buffer-tag-table}
  @see-slot{gtk-text-buffer-text}")

;;; ----------------------------------------------------------------------------
;;;
;;; Property Details
;;;
;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation (atdoc:get-slot-from-name "copy-target-list"
                                               'gtk-text-buffer) 't)
 "The @code{\"copy-target-list\"} property of type @class{gtk-target-list}
  (Read)@br{}
  The list of targets this buffer supports for clipboard copying and as DND
  source. @br{}
  Since 2.10")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation (atdoc:get-slot-from-name "cursor-position"
                                               'gtk-text-buffer) 't)
 "The @code{\"cursor-position\"} property of type @code{:int} (Read)@br{}
  The position of the insert mark (as offset from the beginning of the
  buffer). It is useful for getting notified when the cursor moves. @br{}
  Allowed values: >= 0@br{}
  Default value: 0@br{}
  Since 2.10")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation (atdoc:get-slot-from-name "has-selection"
                                               'gtk-text-buffer) 't)
 "The @code{\"has-selection\"} property of type @code{:boolean} (Read)@br{}
  Whether the buffer has some text currently selected. @br{}
  Default value: @code{nil}@br{}
  Since 2.10")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation (atdoc:get-slot-from-name "paste-target-list"
                                               'gtk-text-buffer) 't)
 "The @code{\"paste-target-list\"} property of type @class{gtk-target-list}
  (Read)@br{}
  The list of targets this buffer supports for clipboard pasting and as DND
  destination. @br{}
  Since 2.10")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation (atdoc:get-slot-from-name "tag-table" 'gtk-text-buffer) 't)
 "The @code{\"tag-table\"} property of type @class{gtk-text-tag-table}
  (Read / Write / Construct)@br{}
  Text Tag Table.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (documentation (atdoc:get-slot-from-name "text" 'gtk-text-buffer) 't)
 "The @code{\"text\"} property of type @code{:string} (Read / Write)@br{}
  The text content of the buffer. Without child widgets and images, see
  @fun{gtk-text-buffer-get-text} for more information. @br{}
  Default value: \"\"@br{}
  Since 2.8")

;;; ----------------------------------------------------------------------------
;;;
;;; Accessors of Properties
;;;
;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-copy-target-list atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-copy-target-list 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"copy-target-list\"} of the
  @class{gtk-text-buffer} class.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-cursor-position atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-cursor-position 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"cursor-position\"} of the @class{gtk-text-buffer}
  class.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-has-selection atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-has-selection 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"has-selection\"} of the @class{gtk-text-buffer}
  class.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-cursor-position atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-cursor-position 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"cursor-position\"} of the @class{gtk-text-buffer}
  class.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-paste-target-list atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-paste-target-list 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"paste-target-list\"} of the
  @class{gtk-text-buffer} class.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-tag-table atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-tag-table 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"tag-table\"} of the @class{gtk-text-buffer}
  class.")

;;; ----------------------------------------------------------------------------

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-text atdoc:*function-name-alias*)
      "Accessor"
      (documentation 'gtk-text-buffer-text 'function)
 "@version{2013-3-23}
  Accessor of the slot @code{\"text\"} of the @class{gtk-text-buffer} class.")

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline gtk-text-buffer-new))

(defun gtk-text-buffer-new (table)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[table]{a tag table, or @code{nil} to create a new one}
  @return{A new text buffer.}
  Creates a new text buffer."
  (make-instance 'gtk-text-buffer
                 :tag-table table))

(export 'gtk-text-buffer-new)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_line_count ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_line_count" gtk-text-buffer-get-line-count) :int
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @return{Number of lines in the buffer.}
  Obtains the number of lines in the buffer. This value is cached, so the
  function is very fast."
  (buffer (g-object gtk-text-buffer)))

(export 'gtk-text-buffer-get-line-count)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_char_count ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_char_count" gtk-text-buffer-get-char-count) :int
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @return{Number of characters in the buffer.}
  Gets the number of characters in the buffer; note that characters and bytes
  are not the same, you can't e.g. expect the contents of the buffer in string
  form to be this many bytes long. The character count is cached, so this
  function is very fast."
  (buffer (g-object gtk-text-buffer)))

(export 'gtk-text-buffer-get-char-count)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_tag_table ()
;;; ----------------------------------------------------------------------------

(declaim (inline gtk-text-buffer-get-tag-table))

(defun gtk-text-buffer-get-tag-table (buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @return{the buffer's tag table}
  Get the GtkTextTagTable associated with this buffer."
  (gtk-text-buffer-tag-table buffer))

(export 'gtk-text-buffer-get-tag-table)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert" %gtk-text-buffer-insert) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (text (:string :free-to-foreign t))
  (len :int))

(defun gtk-text-buffer-insert (buffer text &key
                                      (position :cursor)
                                      (interactive nil)
                                      (default-editable t))
 #+cl-cffi-gtk-documentation
 "@version{2013-4-14}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[text]{text in UTF-8 format}
  Inserts @arg{text} at position iter. Emits the \"insert-text\" signal;
  insertion actually occurs in the default handler for the signal. iter is
  invalidated when insertion occurs (because the buffer contents change), but
  the default signal handler revalidates it to point to the end of the inserted
  text."
  (assert (typep position '(or gtk-text-iter (member :cursor))))
  (if interactive
      (if (eq position :cursor)
          (gtk-text-buffer-insert-interactive-at-cursor buffer
                                                        text
                                                        -1
                                                        default-editable)
          (gtk-text-buffer-insert-interactive buffer
                                              position
                                              text
                                              -1
                                              default-editable))
      (progn
        (if (eq position :cursor)
            (gtk-text-buffer-insert-at-cursor buffer text -1)
            (%gtk-text-buffer-insert buffer position text -1))
        t)))

(export 'gtk-text-buffer-insert)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_at_cursor ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_at_cursor" gtk-text-buffer-insert-at-cursor)
    :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[text]{text in UTF-8 format}
  @argument[len]{length of text, in bytes}
  Simply calls gtk_text_buffer_insert(), using the current cursor position as
  the insertion point."
  (buffer (g-object gtk-text-buffer))
  (text (:string :free-to-foreign t))
  (len :int))

(export 'gtk-text-buffer-insert-at-cursor)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_interactive ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_interactive"
          gtk-text-buffer-insert-interactive) :boolean
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{a position in buffer}
  @argument[text]{some UTF-8 text}
  @argument[len]{length of text in bytes, or -1}
  @argument[default_editable]{default editability of buffer}
  @return{Whether text was actually inserted.}
  @begin{short}
    Like gtk_text_buffer_insert(), but the insertion will not occur if iter is
    at a non-editable location in the buffer. Usually you want to prevent
    insertions at ineditable locations if the insertion results from a user
    action (is interactive).
  @end{short}

  default_editable indicates the editability of text that doesn't have a tag
  affecting editability applied to it. Typically the result of
  gtk_text_view_get_editable() is appropriate here."
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (text (:string :free-to-foreign t))
  (len :int)
  (default-editable :boolean))

(export 'gtk-text-buffer-insert-interactive)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_interactive_at_cursor ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_interactive_at_cursor"
          gtk-text-buffer-insert-interactive-at-cursor) :boolean
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[text]{text in UTF-8 format}
  @argument[len]{length of text in bytes, or -1}
  @argument[default_editable]{default editability of buffer}
  @return{Whether text was actually inserted.}
  @begin{short}
    Calls gtk_text_buffer_insert_interactive() at the cursor position.
  @end{short}

  default_editable indicates the editability of text that doesn't have a tag
  affecting editability applied to it. Typically the result of
  gtk_text_view_get_editable() is appropriate here."
  (buffer (g-object gtk-text-buffer))
  (text (:string :free-to-foreign t))
  (len :int)
  (default-editable :boolean))

(export 'gtk-text-buffer-insert-interactive-at-cursor)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_range ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_range" %gtk-text-buffer-insert-range) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (range-start (g-boxed-foreign gtk-text-iter))
  (range-end (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-insert-range (buffer position range-start range-end &key
                                            interactive default-editable)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{a position in buffer}
  @argument[start]{a position in a GtkTextBuffer}
  @argument[end]{another position in the same buffer as start}
  @begin{short}
    Copies text, tags, and pixbufs between start and end (the order of start and
    end doesn't matter) and inserts the copy at iter. Used instead of simply
    getting/inserting text because it preserves images and tags. If start and
    end are in a different buffer from buffer, the two buffers must share the
    same tag table.
  @end{short}

  Implemented via emissions of the insert_text and apply_tag signals, so
  expect those."
  (if interactive
      (gtk-text-buffer-insert-range-interactive buffer
                                                position
                                                range-start
                                                range-end
                                                default-editable)
      (progn
        (%gtk-text-buffer-insert-range buffer position range-start range-end)
        t)))

(export 'gtk-text-buffer-insert-range)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_range_interactive ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_range_interactive"
          gtk-text-buffer-insert-range-interactive) :boolean
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{a position in buffer}
  @argument[start]{a position in a GtkTextBuffer}
  @argument[end]{another position in the same buffer as start}
  @argument[default_editable]{default editability of the buffer}
  @return{whether an insertion was possible at iter}
  Same as gtk_text_buffer_insert_range(), but does nothing if the insertion
  point isn't editable. The default_editable parameter indicates whether the
  text is editable at iter if no tags enclosing iter affect editability.
  Typically the result of gtk_text_view_get_editable() is appropriate here."
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (range-start (g-boxed-foreign gtk-text-iter))
  (range-end (g-boxed-foreign gtk-text-iter))
  (default-editable :boolean))

(export 'gtk-text-buffer-insert-range)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_with_tags ()
;;; 
;;; void gtk_text_buffer_insert_with_tags (GtkTextBuffer *buffer,
;;;                                        GtkTextIter *iter,
;;;                                        const gchar *text,
;;;                                        gint len,
;;;                                        GtkTextTag *first_tag,
;;;                                        ...);
;;; 
;;; Inserts text into buffer at iter, applying the list of tags to the
;;; newly-inserted text. The last tag specified must be NULL to terminate the
;;; list. Equivalent to calling gtk_text_buffer_insert(), then
;;; gtk_text_buffer_apply_tag() on the inserted text;
;;; gtk_text_buffer_insert_with_tags() is just a convenience function.
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; iter :
;;;     an iterator in buffer
;;; 
;;; text :
;;;     UTF-8 text
;;; 
;;; len :
;;;     length of text, or -1
;;; 
;;; first_tag :
;;;     first tag to apply to text
;;; 
;;; ... :
;;;     NULL-terminated list of tags to apply
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_with_tags_by_name ()
;;; 
;;; void gtk_text_buffer_insert_with_tags_by_name (GtkTextBuffer *buffer,
;;;                                                GtkTextIter *iter,
;;;                                                const gchar *text,
;;;                                                gint len,
;;;                                                const gchar *first_tag_name,
;;;                                                ...);
;;; 
;;; Same as gtk_text_buffer_insert_with_tags(), but allows you to pass in tag
;;; names instead of tag objects.
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; iter :
;;;     position in buffer
;;; 
;;; text :
;;;     UTF-8 text
;;; 
;;; len :
;;;     length of text, or -1
;;; 
;;; first_tag_name :
;;;     name of a tag to apply to text
;;; 
;;; ... :
;;;     more tag names
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_delete ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_delete" %gtk-text-buffer-delete) :void
  (buffer (g-object gtk-text-buffer))
  (range-start (g-boxed-foreign gtk-text-iter))
  (range-end (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-delete (buffer start end &key interactive
                                                     default-editable)
 #+cl-cffi-gtk-documentation
 "@version{2013-4-14}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[start]{a position in buffer}
  @argument[end]{another position in buffer}
  Deletes text between @arg{start} and @arg{end}. The order of @arg{start} and
  @arg{end} is not actually relevant; @sym{gtk-text-buffer-delete} will reorder
  them. This function actually emits the \"delete-range\" signal, and the
  default handler of that signal deletes the text. Because the buffer is
  modified, all outstanding iterators become invalid after calling this
  function; however, the @arg{start} and @arg{end} will be re-initialized to
  point to the location where text was deleted."
  (if interactive
      (gtk-text-buffer-delete-interactive buffer
                                          start
                                          end
                                          default-editable)
      (progn
        (%gtk-text-buffer-delete buffer start end)
        t)))

(export 'gtk-text-buffer-delete)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_delete_interactive ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_delete_interactive"
          gtk-text-buffer-delete-interactive) :boolean
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[start-iter]{start of range to delete}
  @argument[end-iter]{end of range}
  @argument[default-editable]{whether the @arg{buffer} is editable by default}
  @return{Whether some text was actually deleted.}
  Deletes all editable text in the given range. Calls
  @fun{gtk-text-buffer-delete} for each editable sub range of
  [@arg{start}, @arg{end}). @arg{start} and @arg{end} are revalidated to
  point to the location of the last deleted range, or left untouched if no
  text was deleted."
  (buffer (g-object gtk-text-buffer))
  (start-iter (g-boxed-foreign gtk-text-iter))
  (end-iter (g-boxed-foreign gtk-text-iter))
  (default-editable :boolean))

(export 'gtk-text-buffer-delete-interactive)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_backspace ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_backspace" %gtk-text-buffer-backspace) :boolean
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (interactive :boolean)
  (default-editable :boolean))

(defun gtk-text-buffer-backspace (buffer position &key
                                         interactive default-editable)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[iter]{a position in buffer}
  @argument[interactive]{whether the deletion is caused by user interaction}
  @argument[default-editable]{whether the buffer is editable by default}
  @return{@em{True} if the buffer was modified.}
  @begin{short}
    Performs the appropriate action as if the user hit the delete key with the
    cursor at the position specified by iter. In the normal case a single
    character will be deleted, but when combining accents are involved, more
    than one character can be deleted, and when precomposed character and accent
    combinations are involved, less than one character will be deleted.
  @end{short}

  Because the buffer is modified, all outstanding iterators become invalid
  after calling this function; however, the iter will be re-initialized to
  point to the location where text was deleted.

  Since 2.6"
  (%gtk-text-buffer-backspace buffer position interactive default-editable))

(export 'gtk-text-buffer-backspace)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_set_text ()
;;; ----------------------------------------------------------------------------

(declaim (inline gtk-text-buffer-set-text))

(defun gtk-text-buffer-set-text (buffer text)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[text]{UTF-8 text to insert}
  @argument[len]{length of text in bytes}
  Deletes current contents of buffer, and inserts text instead. If len is -1,
  text must be nul-terminated. text must be valid UTF-8."
  (setf (gtk-text-buffer-text buffer) text))

(export 'gtk-text-buffer-set-text)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_text ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_text" gtk-text-buffer-get-text) :string
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[start]{start of a range}
  @argument[end]{end of a range}
  @argument[include-hidden-chars]{whether to include invisible text}
  @return{An allocated UTF-8 string.}
  Returns the text in the range [start,end). Excludes undisplayed text (text
  marked with tags that set the invisibility attribute) if
  @arg{include-hidden-chars} is @code{nil}. Does not include characters
  representing embedded images, so byte and character indexes into the returned
  string do not correspond to byte and character indexes into the buffer.
  Contrast with @fun{gtk-text-buffer-get-slice}."
  (buffer (g-object gtk-text-buffer))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter))
  (include-hidden-chars :boolean))

(export 'gtk-text-buffer-get-text)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_slice ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_slice" %gtk-text-buffer-get-slice)
    (:string :free-from-foreign t)
  (buffer (g-object gtk-text-buffer))
  (range-start (g-boxed-foreign gtk-text-iter))
  (range-end (g-boxed-foreign gtk-text-iter))
  (include-hidden-chars :boolean))

(defun gtk-text-buffer-slice (buffer range-start range-end &key
                                     include-hidden-chars)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[start]{start of a range}
  @argument[end]{end of a range}
  @argument[include_hidden_chars]{whether to include invisible text}
  @return{An allocated UTF-8 string.}
  Returns the text in the range [start,end). Excludes undisplayed text (text
  marked with tags that set the invisibility attribute) if
  include_hidden_chars is FALSE. The returned string includes a 0xFFFC
  character whenever the buffer contains embedded images, so byte and
  character indexes into the returned string do correspond to byte and
  character indexes into the buffer. Contrast with gtk_text_buffer_get_text().
  Note that 0xFFFC can occur in normal text as well, so it is not a reliable
  indicator that a pixbuf or widget is in the buffer."
  (%gtk-text-buffer-get-slice buffer
                              range-start
                              range-end
                              include-hidden-chars))

(export 'gtk-text-buffer-slice)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_pixbuf ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_pixbuf" gtk-text-buffer-insert-pixbuf) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{location to insert the pixbuf}
  @argument[pixbuf]{a GdkPixbuf}
  Inserts an image into the text buffer at iter. The image will be counted as
  one character in character counts, and when obtaining the buffer contents as
  a string, will be represented by the Unicode \"object replacement character\"
  0xFFFC. Note that the \"slice\" variants for obtaining portions of the buffer
  as a string include this character for pixbufs, but the \"text\" variants do
  not. e. g. see gtk_text_buffer_get_slice() and gtk_text_buffer_get_text()."
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (pixbuf (g-object gdk-pixbuf)))

(export 'gtk-text-buffer-insert-pixbuf)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_insert_child_anchor ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_insert_child_anchor"
          %gtk-text-buffer-insert-child-anchor) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (anchor (g-object gtk-text-child-anchor)))

(defun gtk-text-buffer-insert-child-anchor (buffer position &optional anchor)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{location to insert the anchor}
  @argument[anchor]{a GtkTextChildAnchor}
  Inserts a child widget anchor into the text buffer at iter. The anchor will
  be counted as one character in character counts, and when obtaining the
  buffer contents as a string, will be represented by the Unicode
  \"object replacement character\" 0xFFFC. Note that the \"slice\" variants for
  obtaining portions of the buffer as a string include this character for
  child anchors, but the \"text\" variants do not. E. g. see
  gtk_text_buffer_get_slice() and gtk_text_buffer_get_text(). Consider
  gtk_text_buffer_create_child_anchor() as a more convenient alternative to
  this function. The buffer will add a reference to the anchor, so you can
  unref it after insertion."
  (if anchor
      (progn
        (%gtk-text-buffer-insert-child-anchor buffer position anchor)
        anchor)
      (gtk-text-buffer-create-child-anchor buffer position)))

(export 'gtk-text-buffer-insert-child-anchor)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_create_child_anchor ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_create_child_anchor"
          gtk-text-buffer-create-child-anchor) (g-object gtk-text-child-anchor)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[iter]{location in the buffer}
  @return{The created child anchor.}
  This is a convenience function which simply creates a child anchor with
  @fun{gtk-text-child-anchor-new} and inserts it into the buffer with
  @fun{gtk-text-buffer-insert-child-anchor}. The new anchor is owned by the
  buffer; no reference count is returned to the caller of
  @fun{gtk-text-buffer-create-child-anchor}."
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-create-child-anchor)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_create_mark ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_create_mark" %gtk-text-buffer-create-mark)
    (g-object gtk-text-mark)
  (buffer (g-object gtk-text-buffer))
  (mark-name (:string :free-to-foreign t))
  (where (g-boxed-foreign gtk-text-iter))
  (left-gravity :boolean))

(defun gtk-text-buffer-create-mark (buffer mark-name pos
                                    &optional (left-gravity t))
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[mark-name]{name for mark, or @code{nil}}
  @argument[pos]{location to place mark}
  @argument[left-gravity]{whether the mark has left gravity}
  @return{The new @class{gtk-text-mark} object.}
  @begin{short}
    Creates a mark at position @arg{where}. If @arg{mark-name} is @code{nil},
    the mark is anonymous; otherwise, the mark can be retrieved by name using
    @fun{gtk-text-buffer-get-mark}. If a mark has left gravity, and text is
    inserted at the mark's current location, the mark will be moved to the left
    of the newly inserted text. If the mark has right gravity
    (@arg{left-gravity} = @code{nil}), the mark will end up on the right of
    newly inserted text. The standard left-to-right cursor is a mark with right
    gravity (when you type, the cursor stays on the right side of the text
    you're typing).
  @end{short}

  The caller of this function does not own a reference to the returned
  @class{gtk-text-mark}, so you can ignore the return value if you like. Marks
  are owned by the buffer and go away when the buffer does.

  Emits the \"mark-set\" signal as notification of the mark's initial
  placement."
  (%gtk-text-buffer-create-mark buffer mark-name pos left-gravity))

(export 'gtk-text-buffer-create-mark)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_move_mark ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_move_mark" %gtk-text-buffer-move-mark) :void
  (buffer (g-object gtk-text-buffer))
  (mark (g-object gtk-text-mark))
  (position (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-move-mark (buffer mark position)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[mark]{a GtkTextMark}
  @arg[where]{new location for mark in buffer}
  Moves mark to the new location where. Emits the \"mark-set\" signal as
  notification of the move."
  (etypecase mark
    (string (gtk-text-buffer-move-mark-by-name buffer mark position))
    (gtk-text-mark (%gtk-text-buffer-move-mark buffer mark position))))

(export 'gtk-text-buffer-move-mark)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_move_mark_by_name ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_move_mark_by_name" gtk-text-buffer-move-mark-by-name)
    :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[name]{name of a mark}
  @argument[where]{new location for mark}
  Moves the mark named name (which must exist) to location where. See
  gtk_text_buffer_move_mark() for details."
  (buffer (g-object gtk-text-buffer))
  (name (:string :free-to-foreign t))
  (position (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-move-mark-by-name)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_add_mark ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_add_mark" gtk-text-buffer-add-mark) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[mark]{the mark to add}
  @argument[position]{location to place mark}
  @begin{short}
    Adds the mark at position where. The mark must not be added to another
    buffer, and if its name is not @code{nil} then there must not be another
    mark in the buffer with the same name.
  @end{short}

  Emits the \"mark-set\" signal as notification of the mark's initial placement.

  Since 2.12"
  (buffer (g-object gtk-text-buffer))
  (mark (g-object gtk-text-mark))
  (position (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-add-mark)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_delete_mark ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_delete_mark" %gtk-text-buffer-delete-mark) :void
  (buffer (g-object gtk-text-buffer))
  (mark (g-object gtk-text-mark)))

(defun gtk-text-buffer-delete-mark (buffer mark)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[mark]{a GtkTextMark in buffer}
  Deletes mark, so that it's no longer located anywhere in the buffer. Removes
  the reference the buffer holds to the mark, so if you haven't called
  g_object_ref() on the mark, it will be freed. Even if the mark isn't freed,
  most operations on mark become invalid, until it gets added to a buffer
  again with gtk_text_buffer_add_mark(). Use gtk_text_mark_get_deleted() to
  find out if a mark has been removed from its buffer. The \"mark-deleted\"
  signal will be emitted as notification after the mark is deleted."
  (etypecase mark
    (string (gtk-text-buffer-delete-mark-by-name buffer mark))
    (gtk-text-mark (%gtk-text-buffer-delete-mark buffer mark))))

(export 'gtk-text-buffer-delete-mark)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_delete_mark_by_name ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_delete_mark_by_name"
          gtk-text-buffer-delete-mark-by-name) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[name]{name of a mark in buffer}
  Deletes the mark named name; the mark must exist. See
  gtk_text_buffer_delete_mark() for details."
  (buffer (g-object gtk-text-buffer))
  (name (:string :free-to-foreign t)))

(export 'gtk-delete-mark-by-name)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_mark ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_mark" gtk-text-buffer-get-mark)
    (g-object gtk-text-mark)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[name]{a mark name}
  @return{A GtkTextMark, or NULL}
  Returns the mark named name in buffer buffer, or NULL if no such mark exists
  in the buffer."
  (buffer (g-object gtk-text-buffer))
  (name (:string :free-to-foreign t)))

(export 'gtk-text-buffer-get-mark)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_insert ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_insert" gtk-text-buffer-get-insert)
    (g-object gtk-text-mark)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @return{insertion point mark}
  Returns the mark that represents the cursor (insertion point). Equivalent to
  calling gtk_text_buffer_get_mark() to get the mark named \"insert\", but very
  slightly more efficient, and involves less typing."
  (buffer (g-object gtk-text-buffer)))

(export 'gtk-text-buffer-get-insert)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_selection_bound ()
;;; ----------------------------------------------------------------------------

(defcfun (gtk-text-buffer-selection-bound "gtk_text_buffer_get_selection_bound")
    (g-object gtk-text-mark)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @return{selection bound mark}
  @begin{short}
    Returns the mark that represents the selection bound. Equivalent to calling
    gtk_text_buffer_get_mark() to get the mark named \"selection_bound\", but
    very slightly more efficient, and involves less typing.
  @end{short}

  The currently-selected text in buffer is the region between the
  \"selection_bound\" and \"insert\" marks. If \"selection_bound\" and
  \"insert\" are in the same place, then there is no current selection.
  gtk_text_buffer_get_selection_bounds() is another convenient function for
  handling the selection, if you just want to know whether there's a selection
  and what its bounds are."
  (buffer (g-object gtk-text-buffer)))

(export 'gtk-text-buffer-selection-bound)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_has_selection ()
;;; 
;;; gboolean gtk_text_buffer_get_has_selection (GtkTextBuffer *buffer);
;;; 
;;; Indicates whether the buffer has some text currently selected.
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; Returns :
;;;     TRUE if the there is text selected
;;; 
;;; Since 2.10
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_place_cursor ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_place_cursor" gtk-text-buffer-place-cursor) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[where]{where to put the cursor}
  This function moves the \"insert\" and \"selection_bound\" marks
  simultaneously. If you move them to the same place in two steps with
  gtk_text_buffer_move_mark(), you will temporarily select a region in between
  their old and new locations, which can be pretty inefficient since the
  temporarily-selected region will force stuff to be recalculated. This
  function moves them as a unit, which can be optimized."
  (buffer (g-object gtk-text-buffer))
  (position (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-place-cursor)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_select_range ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_select_range" gtk-text-buffer-select-range) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[ins]{where to put the \"insert\" mark}
  @argument[bound]{where to put the \"selection_bound\" mark}
  @begin{short}
    This function moves the \"insert\" and \"selection_bound\" marks
    simultaneously. If you move them in two steps with
    gtk_text_buffer_move_mark(), you will temporarily select a region in
    between their old and new locations, which can be pretty inefficient since
    the temporarily-selected region will force stuff to be recalculated. This
    function moves them as a unit, which can be optimized.
  @end{short}

  Since 2.4"
  (buffer (g-object gtk-text-buffer))
  (insertion-point (g-boxed-foreign gtk-text-iter))
  (selection-bound (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-select-range)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_apply_tag ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_apply_tag" %gtk-text-buffer-apply-tag) :void
  (buffer (g-object gtk-text-buffer))
  (tag (g-object gtk-text-tag))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-apply-tag (buffer tag start end)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[tag]{a @class{gtk-text-tag} object}
  @argument[start]{one bound of range to be tagged}
  @argument[end]{other bound of range to be tagged}
  Emits the \"apply-tag\" signal on buffer. The default handler for the signal
  applies tag to the given range. start and end do not have to be in order."
  (etypecase tag
    (string (gtk-text-buffer-apply-tag-by-name buffer tag start end))
    (gtk-text-tag (%gtk-text-buffer-apply-tag buffer tag start end))))

(export 'gtk-text-buffer-apply-tag)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_remove_tag ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_remove_tag" %gtk-text-buffer-remove-tag) :void
  (buffer (g-object gtk-text-buffer))
  (tag (g-object gtk-text-tag))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-remove-tag (buffer tag start end)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[tag]{a GtkTextTag}
  @argument[start]{one bound of range to be untagged}
  @argument[end]{other bound of range to be untagged}
  Emits the \"remove-tag\" signal. The default handler for the signal removes
  all occurrences of tag from the given range. start and end don't have to be
  in order."
  (etypecase tag
    (string (gtk-text-buffer-remove-tag-by-name buffer tag start end))
    (gtk-text-tag (%gtk-text-buffer-remove-tag buffer tag start end))))

(export 'gtk-text-buffer-remove-tag)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_apply_tag_by_name ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_apply_tag_by_name"
          gtk-text-buffer-apply-tag-by-name) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[name]{name of a named @class{gtk-text-tag} object}
  @argument[start]{one bound of range to be tagged}
  @argument[end]{other bound of range to be tagged}
  Calls @fun{gtk-text-tag-table-lookup} on the buffer's tag table to get a
  @class{gtk-text-tag}, then calls @fun{gtk-text-buffer-apply-tag}."
  (buffer (g-object gtk-text-buffer))
  (name (:string :free-to-foreign t))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-apply-tag-by-name)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_remove_tag_by_name ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_remove_tag_by_name"
          gtk-text-buffer-remove-tag-by-name) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[name]{name of a GtkTextTag}
  @argument[start]{one bound of range to be untagged}
  @argument[end]{other bound of range to be untagged}
  Calls gtk_text_tag_table_lookup() on the buffer's tag table to get a
  GtkTextTag, then calls gtk_text_buffer_remove_tag()."
  (buffer (g-object gtk-text-buffer))
  (name (:string :free-to-foreign t))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-remove-tag-by-name)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_remove_all_tags ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_remove_all_tags" gtk-text-buffer-remove-all-tags)
    :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[start]{one bound of range to be untagged}
  @argument[end]{other bound of range to be untagged}
  Removes all tags in the range between start and end. Be careful with this
  function; it could remove tags added in code unrelated to the code you're
  currently writing. That is, using this function is probably a bad idea if
  you have two or more unrelated code sections that add tags."
  (buffer (g-object gtk-text-buffer))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(export 'gtk-text-buffer-remove-all-tags)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_create_tag ()
;;; 
;;; GtkTextTag * gtk_text_buffer_create_tag (GtkTextBuffer *buffer,
;;;                                          const gchar *tag_name,
;;;                                          const gchar *first_property_name,
;;;                                          ...);
;;; 
;;; Creates a tag and adds it to the tag table for buffer. Equivalent to calling
;;; gtk_text_tag_new() and then adding the tag to the buffer's tag table. The
;;; returned tag is owned by the buffer's tag table, so the ref count will be
;;; equal to one.
;;; 
;;; If tag_name is NULL, the tag is anonymous.
;;; 
;;; If tag_name is non-NULL, a tag called tag_name must not already exist in the
;;; tag table for this buffer.
;;; 
;;; The first_property_name argument and subsequent arguments are a list of
;;; properties to set on the tag, as with g_object_set().
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; tag_name :
;;;     name of the new tag, or NULL
;;; 
;;; first_property_name :
;;;     name of first property to set, or NULL
;;; 
;;; ... :
;;;     NULL-terminated list of property names and values
;;; 
;;; Returns :
;;;     a new tag
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_iter_at_line_offset ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_iter_at_line_offset"
          %gtk-text-buffer-get-iter-at-line-offset) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (line-number :int)
  (char-offset :int))

(defun gtk-text-buffer-get-iter-at-line-offset (buffer line-number char-offset)
 #+cl-cffi-gtk-documentation
 "@version{20913-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{iterator to initialize}
  @argument[line_number]{line number counting from 0}
  @argument[char_offset]{char offset from start of line}
  Obtains an iterator pointing to char_offset within the given line. The
  char_offset must exist, offsets off the end of the line are not allowed.
  Note characters, not bytes; UTF-8 may encode one character as multiple
  bytes."
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-iter-at-line-offset buffer
                                              iter
                                              line-number
                                              char-offset)
    iter))

(export 'gtk-text-buffer-get-iter-at-line-offset)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_iter_at_offset ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_iter_at_offset"
          %gtk-text-buffer-get-iter-at-offset) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (char-offset :int))

(defun gtk-text-buffer-get-iter-at-offset (buffer offset)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{iterator to initialize}
  @argument[char_offset]{char offset from start of buffer, counting from 0,
    or -1}
  Initializes iter to a position char_offset chars from the start of the
  entire buffer. If char_offset is -1 or greater than the number of characters
  in the buffer, iter is initialized to the end iterator, the iterator one
  past the last valid character in the buffer."
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-iter-at-offset buffer iter offset)
    iter))

(export 'gtk-text-buffer-get-iter-at-offset)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_iter_at_line ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_iter_at_line" %gtk-text-buffer-get-iter-at-line)
    :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (line-number :int))

(defun gtk-text-buffer-get-iter-at-line (buffer line-number)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{iterator to initialize}
  @argument[line_number]{line number counting from 0}
  Initializes iter to the start of the given line."
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-iter-at-line buffer iter line-number)
    iter))

(export 'gtk-text-buffet-get-iter-at-line)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_iter_at_line_index ()
;;; 
;;; void gtk_text_buffer_get_iter_at_line_index (GtkTextBuffer *buffer,
;;;                                              GtkTextIter *iter,
;;;                                              gint line_number,
;;;                                              gint byte_index);
;;; 
;;; Obtains an iterator pointing to byte_index within the given line.
;;; byte_index must be the start of a UTF-8 character, and must not be beyond
;;; the end of the line. Note bytes, not characters; UTF-8 may encode one
;;; character as multiple bytes.
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; iter :
;;;     iterator to initialize
;;; 
;;; line_number :
;;;     line number counting from 0
;;; 
;;; byte_index :
;;;     byte index from start of line
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_iter_at_mark ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_iter_at_mark" %gtk-text-buffer-get-iter-at-mark)
    :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (mark (g-object gtk-text-mark)))

(defun gtk-text-buffer-get-iter-at-mark (buffer mark)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{iterator to initialize}
  @argument[mark]{a GtkTextMark in buffer}
  Initializes iter with the current position of mark."
  (when (stringp mark)
    (setf mark (gtk-text-buffer-get-mark buffer mark)))
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-iter-at-mark buffer iter mark)
    iter))

(export 'gtk-text-buffer-get-iter-at-mark)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_iter_at_child_anchor ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_iter_at_child_anchor"
          %gtk-text-buffer-get-iter-at-child-anchor) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter))
  (anchor (g-object gtk-text-child-anchor)))

(defun gtk-text-buffer-get-iter-at-child-anchor (buffer anchor)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{an iterator to be initialized}
  @argument[anchor]{a child anchor that appears in buffer}
  Obtains the location of anchor within buffer."
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-iter-at-child-anchor buffer iter anchor)
    iter))

(export 'gtk-text-buffer-get-iter-at-child-anchor)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_start_iter ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_start_iter" %gtk-text-buffer-get-start-iter)
    :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-get-start-iter (buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{iterator to initialize}
  Initialized iter with the first position in the text buffer. This is the
  same as using gtk_text_buffer_get_iter_at_offset() to get the iter at
  character offset 0."
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-start-iter buffer iter)
    iter))

(export 'gtk-text-buffer-get-start-iter)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_end_iter ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_end_iter" %gtk-text-buffer-get-end-iter) :void
  (buffer (g-object gtk-text-buffer))
  (iter (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-get-end-iter (buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[iter]{iterator to initialize}
  Initializes iter with the \"end iterator\", one past the last valid character
  in the text buffer. If dereferenced with gtk_text_iter_get_char(), the end
  iterator has a character value of 0. The entire buffer lies in the range
  from the first position in the buffer (call gtk_text_buffer_get_start_iter()
  to get character position 0) to the end iterator."
  (let ((iter (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-end-iter buffer iter)
    iter))

(export 'gtk-text-buffer-get-end-iter)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_bounds ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_bounds" %gtk-text-buffer-get-bounds) :void
  (buffer (g-object gtk-text-buffer))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-get-bounds (buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-4-14}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @begin{return}
    @code{start} -- iterator with first position in the buffer@br{}
    @code{end} -- iterator with the end iterator
  @end{return}
  Retrieves the first and last iterators in the buffer, i. e. the entire buffer
  lies within the range [@arg{start},@arg{end})."
  (let ((start (make-instance 'gtk-text-iter))
        (end (make-instance 'gtk-text-iter)))
    (%gtk-text-buffer-get-bounds buffer start end)
    (values start end)))

(export 'gtk-text-buffer-get-bounds)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_modified ()
;;; 
;;; gboolean gtk_text_buffer_get_modified (GtkTextBuffer *buffer);
;;; 
;;; Indicates whether the buffer has been modified since the last call to
;;; gtk_text_buffer_set_modified() set the modification flag to FALSE. Used for
;;; example to enable a "save" function in a text editor.
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; Returns :
;;;     TRUE if the buffer has been modified
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_set_modified ()
;;; 
;;; void gtk_text_buffer_set_modified (GtkTextBuffer *buffer,
;;;                                    gboolean setting);
;;; 
;;; Used to keep track of whether the buffer has been modified since the last
;;; time it was saved. Whenever the buffer is saved to disk, call
;;; gtk_text_buffer_set_modified (buffer, FALSE). When the buffer is modified,
;;; it will automatically toggled on the modified bit again. When the modified
;;; bit flips, the buffer emits a "modified-changed" signal.
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; setting :
;;;     modification flag setting
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_delete_selection ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_delete_selection" %gtk-text-buffer-delete-selection)
    :boolean
  (bufer (g-object gtk-text-buffer))
  (interactive :boolean)
  (default-editable :boolean))

(defun gtk-text-buffer-delete-selection (buffer &key
                                                interactive default-editable)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[interactive]{whether the deletion is caused by user interaction}
  @argument[default_editable]{whether the buffer is editable by default}
  @return{Whether there was a non-empty selection to delete.}
  Deletes the range between the \"insert\" and \"selection_bound\" marks, that
  is, the currently-selected text. If interactive is TRUE, the editability of
  the selection will be considered (users can't delete uneditable text)."
  (%gtk-text-buffer-delete-selection buffer interactive default-editable))

(export 'gtk-text-buffer-delete-selection)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_paste_clipboard ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_paste_clipboard" %gtk-text-buffer-paste-clipboard)
    :void
  (buffer (g-object gtk-text-buffer))
  (clipboard (g-object gtk-clipboard))
  (override-location (g-boxed-foreign gtk-text-iter))
  (default-editable :boolean))

(defun gtk-text-buffer-paste-clipboard (buffer clipboard &key
                                               position default-editable)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[clipboard]{the GtkClipboard to paste from}
  @argument[override_location]{location to insert pasted text, or NULL for at
    the cursor}
  @argument[default_editable]{whether the buffer is editable by default}
  Pastes the contents of a clipboard at the insertion point, or at
  override_location. (Note: pasting is asynchronous, that is, we'll ask for
  the paste data and return, and at some point later after the main loop runs,
  the paste data will be inserted.)"
  (%gtk-text-buffer-paste-clipboard buffer clipboard position default-editable))

(export 'gtk-text-buffer-paste-clipboard)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_copy_clipboard ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_copy_clipboard" gtk-text-buffer-copy-clipboard) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[clipboard]{the @class{gtk-clipboard} object to copy to}
  Copies the currently selected text to a @arg{clipboard}."
  (buffer (g-object gtk-text-buffer))
  (clipboard (g-object gtk-clipboard)))

(export 'gtk-text-buffer-copy-clipboard)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_cut_clipboard ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_cut_clipboard" gtk-text-buffer-cut-clipboard) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[clipboard]{the @class{gtk-clipboard} object to cut to}
  @argument[default-editable]{default editability of the @arg{buffer}}
  Copies the currently selected text to a @arg{clipboard}, then deletes said
  text if it's editable."
  (buffer (g-object gtk-text-buffer))
  (clipboard (g-object gtk-clipboard))
  (default-editable :boolean))

(export 'gtk-text-buffer-cut-clipboard)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_selection_bounds ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_selection_bounds"
          %gtk-text-buffer-get-selection-bounds) :boolean
  (buffer (g-object gtk-text-buffer))
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter)))

(defun gtk-text-buffer-get-selection-bounds (buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer a GtkTextBuffer}
  @argument[start]{iterator to initialize with selection start}
  @argument[end]{iterator to initialize with selection end}
  @return{Whether the selection has nonzero length.}
  Returns TRUE if some text is selected; places the bounds of the selection in
  start and end (if the selection has length 0, then start and end are filled
  in with the same value). start and end will be in ascending order. If start
  and end are NULL, then they are not filled in, but the return value still
  indicates whether text is selected."
  (let ((i1 (make-instance 'gtk-text-iter))
        (i2 (make-instance 'gtk-text-iter)))
    (if (%gtk-text-buffer-get-selection-bounds buffer i1 i2)
        (values i1 i2)
        (values nil nil))))

(export 'gtk-text-buffer-get-selection-bounds)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_begin_user_action ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_begin_user_action" gtk-text-buffer-begin-user-action)
    :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @begin{short}
    Called to indicate that the buffer operations between here and a call to
    @fun{gtk-text-buffer-end-user-action} are part of a single user-visible
    operation. The operations between @fun{gtk-text-buffer-begin-user-action}
    and @fun{gtk-text-buffer-end-user-action} can then be grouped when creating
    an undo stack. @class{gtk-text-buffer} maintains a count of calls to
    @fun{gtk-text-buffer-begin-user-action} that have not been closed with a
    call to @fun{gtk-text-buffer-end-user-action}, and emits the
    \"begin-user-action\" and \"end-user-action\" signals only for the outermost
    pair of calls. This allows you to build user actions from other user
    actions.
  @end{short}

  The \"interactive\" buffer mutation functions, such as
  @fun{gtk-text-buffer-insert-interactive}, automatically call begin/end user
  action around the buffer operations they perform, so there's no need to add
  extra calls if you user action consists solely of a single call to one of
  those functions."
  (buffer (g-object gtk-text-buffer)))

(export 'gtk-text-buffer-begin-user-action)

;;; ----------------------------------------------------------------------------

(defmacro with-text-buffer-user-action ((buffer) &body body)
  (let ((g (gensym)))
    `(let ((,g ,buffer))
       (text-buffer-begin-user-action ,g)
       (unwind-protect
            (progn ,@body)
         (text-buffer-end-user-action ,g)))))

(export 'with-text-buffer-user-action)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_end_user_action ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_end_user_action" gtk-text-buffer-end-user-action)
    :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  Should be paired with a call to gtk_text_buffer_begin_user_action(). See
  that function for a full explanation."
  (buffer (g-object gtk-text-buffer)))

(export 'gtk-text-buffer-end-user-action)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_add_selection_clipboard ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_add_selection_clipboard"
           gtk-text-buffer-add-selection-clipboard) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-23}
  @argument[buffer]{a @class{gtk-text-buffer} object}
  @argument[clipboard]{a @class{gtk-clipboard} object}
  Adds clipboard to the list of clipboards in which the selection contents of
  buffer are available. In most cases, clipboard will be the
  @class{gtk-clipboard} of type @code{:primary} for a view of buffer."
  (buffer (g-object gtk-text-buffer))
  (clipboard (g-object gtkclipboard)))

(export 'gtk-text-buffer-add-selection-clipboard)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_remove_selection_clipboard ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_remove_selection_clipboard"
          gtk-text-buffer-remove-selection-clipboard) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[clipboard]{a GtkClipboard added to buffer by
    gtk_text_buffer_add_selection_clipboard()}
  Removes a GtkClipboard added with gtk_text_buffer_add_selection_clipboard()."
  (buffer (g-object gtk-text-buffer))
  (clipboard (g-object gtk-clipboard)))

(export 'gtk-text-buffer-remove-selection-clipboard)

;;; ----------------------------------------------------------------------------
;;; enum GtkTextBufferTargetInfo
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkTextBufferTargetInfo" gtk-text-buffer-target-info
  (:export t
   :type-initializer "gtk_text_buffer_target_info_get_type")
  (:buffer-contents -1)
  (:rich-text -2)
  (:text -3))

#+cl-cffi-gtk-documentation
(setf (gethash 'gtk-text-buffer-target-info atdoc:*symbol-name-alias*) "Enum"
      (gethash 'gtk-text-buffer-target-info atdoc:*external-symbols*)
 "@version{2013-3-24}
  @short{}
  @begin{pre}
(define-g-enum \"GtkTextBufferTargetInfo\" gtk-text-buffer-target-info
  (:export t
   :type-initializer \"gtk_text_buffer_target_info_get_type\")
  (:buffer-contents -1)
  (:rich-text -2)
  (:text -3))
  @end{pre}")

;;; ----------------------------------------------------------------------------
;;; GtkTextBufferDeserializeFunc ()
;;; 
;;; gboolean (*GtkTextBufferDeserializeFunc) (GtkTextBuffer *register_buffer,
;;;                                           GtkTextBuffer *content_buffer,
;;;                                           GtkTextIter *iter,
;;;                                           const guint8 *data,
;;;                                           gsize length,
;;;                                           gboolean create_tags,
;;;                                           gpointer user_data,
;;;                                           GError **error);
;;; 
;;; A function that is called to deserialize rich text that has been serialized
;;; with gtk_text_buffer_serialize(), and insert it at iter.
;;; 
;;; register_buffer :
;;;     the GtkTextBuffer the format is registered with
;;; 
;;; content_buffer :
;;;     the GtkTextBuffer to deserialize into
;;; 
;;; iter :
;;;     insertion point for the deserialized text
;;; 
;;; data :
;;;     data to deserialize
;;; 
;;; length :
;;;     length of data
;;; 
;;; create_tags :
;;;     TRUE if deserializing may create tags
;;; 
;;; user_data :
;;;     user data that was specified when registering the format
;;; 
;;; error :
;;;     return location for a GError
;;; 
;;; Returns :
;;;     TRUE on success, FALSE otherwise
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_deserialize ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_deserialize" %gtk-text-buffer-deserialize) :boolean
  (register-buffer (g-object gtk-text-buffer))
  (content-buffer (g-object gtk-text-buffer))
  (format gdk-atom-as-string)
  (iter (g-boxed-foreign gtk-text-iter))
  (data :pointer)
  (length g-size)
  (error :pointer))

(defun gtk-text-buffer-deserialize (register-buffer content-buffer
                                                    format iter data)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[register_buffer]{the GtkTextBuffer format is registered with}
  @argument[content_buffer]{the GtkTextBuffer to deserialize into}
  @argument[format]{the rich text format to use for deserializing}
  @argument[iter]{insertion point for the deserialized text}
  @argument[data]{data to deserialize}
  @argument[length]{length of data}
  @argument[error]{return location for a GError}
  @return{TRUE on success, FALSE otherwise.}
  @begin{short}
    This function deserializes rich text in format format and inserts it at
    iter.
  @end{short}

  formats to be used must be registered using
  gtk_text_buffer_register_deserialize_format() or
  gtk_text_buffer_register_deserialize_tagset() beforehand.

  Since 2.10"
  (let ((bytes (foreign-alloc :uint8 :count (length data))))
    (iter (for i from 0 below (length data))
          (setf (mem-aref bytes :uint8 i) (aref data i)))
    (unwind-protect
         (with-g-error (err)
           (%gtk-text-buffer-deserialize register-buffer content-buffer
                                         format iter bytes (length data) err))
      (foreign-free bytes))))

(export 'gtk-text-buffer-deserialize)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_deserialize_get_can_create_tags ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_deserialize_get_can_create_tags"
          gtk-text-buffer-deserialize-can-create-tags) :boolean
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[format]{a GdkAtom representing a registered rich text format}
  @return{Whether deserializing this format may create tags.}
  @begin{short}
    This functions returns the value set with
    gtk_text_buffer_deserialize_set_can_create_tags()
  @end{short}

  Since 2.10"
  (buffer (g-object gtk-text-buffer))
  (format gdk-atom-as-string))

(export 'gtk-text-buffer-deserialize-can-create-tags)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_deserialize_set_can_create_tags ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_deserialize_set_can_create_tags"
          %gtk-text-buffer-deserialize-set-can-create-tags) :void
  (buffer (g-object gtk-text-buffer))
  (format gdk-atom-as-string)
  (can-create-tags :boolean))

(defun (setf gtk-text-buffer-deserialize-can-create-tags)
       (new-value buffer format)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[format]{a GdkAtom representing a registered rich text format}
  @argument[can_create_tags]{whether deserializing this format may create tags}
  @begin{short}
    Use this function to allow a rich text deserialization function to create
    new tags in the receiving buffer. Note that using this function is almost
    always a bad idea, because the rich text functions you register should know
    how to map the rich text format they handler to your text buffers set of
    tags.
  @end{short}

  The ability of creating new (arbitrary!) tags in the receiving buffer is
  meant for special rich text formats like the internal one that is registered
  using gtk_text_buffer_register_deserialize_tagset(), because that format is
  essentially a dump of the internal structure of the source buffer, including
  its tag names.

  You should allow creation of tags only if you know what you are doing, e.g.
  if you defined a tagset name for your application suite's text buffers and
  you know that it's fine to receive new tags from these buffers, because you
  know that your application can handle the newly created tags.

  Since 2.10"
  (%gtk-text-buffer-deserialize-set-can-create-tags buffer format new-value))

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_copy_target_list ()
;;; 
;;; GtkTargetList * gtk_text_buffer_get_copy_target_list (GtkTextBuffer *buffer)
;;; 
;;; This function returns the list of targets this text buffer can provide for
;;; copying and as DND source. The targets in the list are added with info
;;; values from the GtkTextBufferTargetInfo enum, using
;;; gtk_target_list_add_rich_text_targets() and
;;; gtk_target_list_add_text_targets().
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; Returns :
;;;     the GtkTargetList
;;; 
;;; Since 2.10
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_deserialize_formats ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_deserialize_formats"
          %gtk-text-buffer-get-deserialize-formats)
    (:pointer gdk-atom-as-string)
  (text-buffer (g-object gtk-text-buffer))
  (n-formats (:pointer :int)))

(defun gtk-text-buffer-get-deserialize-formats (text-buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[n_formats]{return location for the number of formats}
  @return{An array of GdkAtoms representing the registered formats.}
  @begin{short}
    This function returns the rich text deserialize formats registered with
    buffer using gtk_text_buffer_register_deserialize_format() or
    gtk_text_buffer_register_deserialize_tagset()
  @end{short}

  Since 2.10"
  (with-foreign-object (n-formats :int)
    (let ((atoms-ptr (%gtk-text-buffer-get-deserialize-formats text-buffer
                                                               n-formats)))
      (iter (for i from 0 below (mem-ref n-formats :int))
            (for atom = (mem-aref atoms-ptr 'gdk-atom-as-string i))
            (collect atom)))))

(export 'gtk-text-buffer-get-deserialize-formats)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_paste_target_list ()
;;; 
;;; GtkTargetList * gtk_text_buffer_get_paste_target_list
;;;                                                     (GtkTextBuffer *buffer);
;;; 
;;; This function returns the list of targets this text buffer supports for
;;; pasting and as DND destination. The targets in the list are added with info
;;; values from the GtkTextBufferTargetInfo enum, using
;;; gtk_target_list_add_rich_text_targets() and
;;; gtk_target_list_add_text_targets().
;;; 
;;; buffer :
;;;     a GtkTextBuffer
;;; 
;;; Returns :
;;;     the GtkTargetList
;;; 
;;; Since 2.10
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_get_serialize_formats ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_get_serialize_formats"
          %gtk-text-buffer-get-serialize-formats) (:pointer gdk-atom-as-string)
  (text-buffer (g-object gtk-text-buffer))
  (n-formats (:pointer :int)))

(defun gtk-text-buffer-get-serialize-formats (text-buffer)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}  
  @argument[buffer]{a GtkTextBuffer}
  @argument[n_formats]{return location for the number of formats}
  @return{an array of GdkAtoms representing the registered formats}
  @begin{short}
    This function returns the rich text serialize formats registered with buffer
    using gtk_text_buffer_register_serialize_format() or
    gtk_text_buffer_register_serialize_tagset()
  @end{short}

  Since 2.10"
  (with-foreign-object (n-formats :int)
    (let ((atoms-ptr (%gtk-text-buffer-get-serialize-formats text-buffer
                                                             n-formats)))
      (iter (for i from 0 below (mem-ref n-formats :int))
            (for atom = (mem-aref atoms-ptr 'gdk-atom-as-string i))
            (collect atom)))))

(export 'gtk-text-buffer-get-serialize-formats)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_register_deserialize_format ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_register_deserialize_format"
          %gtk-text-buffer-register-deserialize-format) gdk-atom-as-string
  (buffer (g-object gtk-text-buffer))
  (mime-type :string)
  (function :pointer)
  (user-data :pointer)
  (destroy-notify :pointer))

(defun gtk-text-buffer-register-deserialize-format (buffer mime-type func)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[mime_type]{the format's mime-type}
  @argument[function]{the deserialize function to register}
  @argument[user_data]{function's user_data}
  @argument[user_data_destroy]{a function to call when user_data is no longer
    needed}
  @begin{return}
    The GdkAtom that corresponds to the newly registered format's mime-type.
  @end{return}
  @begin{short}
    This function registers a rich text deserialization function along with its
    mime_type with the passed buffer.
  @end{short}

  Since 2.10"
  (%gtk-text-buffer-register-deserialize-format
                                   buffer
                                   mime-type
                                   (callback gtk-text-buffer-deserialize-cb)
                                   (glib::allocate-stable-pointer func)
                                   (callback glib::stable-pointer-destroy-notify-cb)))

(export 'gtk-text-buffer-register-deserialize-format)

;;; ----------------------------------------------------------------------------

(defcallback gtk-text-buffer-deserialize-cb :boolean
    ((register-buffer (g-object gtk-text-buffer))
     (content-buffer (g-object gtk-text-buffer))
     (iter (g-boxed-foreign gtk-text-iter))
     (data :pointer)
     (length g-size)
     (create-tags :boolean)
     (user-data :pointer)
     (error :pointer))
  (with-catching-to-g-error (error)
    (let ((fn (glib::get-stable-pointer-value user-data)))
      (restart-case
       (let ((bytes (iter (with bytes = (make-array length
                                                    :element-type
                                                    '(unsigned-byte 8)))
                           (for i from 0 below length)
                           (setf (aref bytes i) (mem-ref data :uint8 i))
                           (finally (return bytes)))))
         (progn
           (funcall fn register-buffer content-buffer iter bytes create-tags)
           t))
        (return-from-gtk-text-buffer-deserialize-cb ()
          (error 'g-error-condition
                 :domain "cl-gtk2"
                 :code 0
                 :message
               "'return-from-gtk-text-buffer-deserialize-cb' restart was called"
                 ))))))

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_register_deserialize_tagset ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_register_deserialize_tagset"
          gtk-text-buffer-register-deserialize-tagset) gdk-atom-as-string
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[tagset_name]{an optional tagset name, on NULL}
  @begin{return}
    The GdkAtom that corresponds to the newly registered format's mime-type.
  @end{return}
  @begin{short}
    This function registers GTK+'s internal rich text serialization format with
    the passed buffer. See gtk_text_buffer_register_serialize_tagset() for
    details.
  @end{short}

  Since 2.10"
  (buffer (g-object gtk-text-buffer))
  (tagset-name :string))

(export 'gtk-text-buffer-register-deserialize-tagset)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_register_serialize_format ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_register_serialize_format"
          %gtk-text-buffer-register-serialize-format) gdk-atom-as-string
  (buffer (g-object gtk-text-buffer))
  (mime-type :string)
  (function :pointer)
  (user-data :pointer)
  (destroy-notify :pointer))

(defun gtk-text-buffer-register-serialize-format (buffer mime-type function)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[mime_type]{the format's mime-type}
  @argument[function]{the serialize function to register}
  @argument[user_data]{function's user_data}
  @argument[user_data_destroy]{a function to call when user_data is no longer
    needed}
  @begin{return}
    The GdkAtom that corresponds to the newly registered format's mime-type.
  @end{return}
  @begin{short}
    This function registers a rich text serialization function along with its
    mime_type with the passed buffer.
  @end{short}

  Since 2.10"
  (%gtk-text-buffer-register-serialize-format
                                   buffer
                                   mime-type
                                   (callback gtk-text-buffer-serialize-cb)
                                   (glib::allocate-stable-pointer function)
                                   (callback glib::stable-pointer-destroy-notify-cb)))

(export 'gtk-text-buffer-register-serialize-format)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_register_serialize_tagset ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_register_serialize_tagset"
          gtk-text-buffer-register-serialize-tagset) gdk-atom-as-string
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[tagset_name]{an optional tagset name, on NULL}
  @begin{return}
    The GdkAtom that corresponds to the newly registered format's mime-type.
  @end{return}
  @begin{short}
    This function registers GTK+'s internal rich text serialization format with
    the passed buffer. The internal format does not comply to any standard rich
    text format and only works between GtkTextBuffer instances. It is capable of
    serializing all of a text buffer's tags and embedded pixbufs.
  @end{short}

  This function is just a wrapper around
  gtk_text_buffer_register_serialize_format(). The mime type used for
  registering is \"application/x-gtk-text-buffer-rich-text\", or
  \"application/x-gtk-text-buffer-rich-text;format=tagset_name\" if a
  tagset_name was passed.

  The tagset_name can be used to restrict the transfer of rich text to buffers
  with compatible sets of tags, in order to avoid unknown tags from being
  pasted. It is probably the common case to pass an identifier != NULL here,
  since the NULL tagset requires the receiving buffer to deal with with
  pasting of arbitrary tags.

  Since 2.10"
  (buffer (g-object gtk-text-buffer))
  (tagset-name :string))

(export 'gtk-text-buffer-register-serialize-tagset)

;;; ----------------------------------------------------------------------------
;;; GtkTextBufferSerializeFunc ()
;;; 
;;; guint8 * (*GtkTextBufferSerializeFunc) (GtkTextBuffer *register_buffer,
;;;                                         GtkTextBuffer *content_buffer,
;;;                                         const GtkTextIter *start,
;;;                                         const GtkTextIter *end,
;;;                                         gsize *length,
;;;                                         gpointer user_data);
;;; 
;;; A function that is called to serialize the content of a text buffer. It must
;;; return the serialized form of the content.
;;; 
;;; register_buffer :
;;;     the GtkTextBuffer for which the format is registered
;;; 
;;; content_buffer :
;;;     the GtkTextBuffer to serialize
;;; 
;;; start :
;;;     start of the block of text to serialize
;;; 
;;; end :
;;;     end of the block of text to serialize
;;; 
;;; length :
;;;     Return location for the length of the serialized data
;;; 
;;; user_data :
;;;     user data that was specified when registering the format
;;; 
;;; Returns :
;;;     a newly-allocated array of guint8 which contains the serialized data, or
;;;     NULL if an error occurred
;;; ----------------------------------------------------------------------------

(defcallback gtk-text-buffer-serialize-cb :pointer
    ((register-buffer (g-object gtk-text-buffer))
     (content-buffer (g-object gtk-text-buffer))
     (start-iter (g-boxed-foreign gtk-text-iter))
     (end-iter (g-boxed-foreign gtk-text-iter))
     (length (:pointer g-size))
     (user-data :pointer))
  (let ((fn (glib::get-stable-pointer-value user-data)))
    (restart-case
     (let* ((bytes (funcall fn
                             register-buffer
                             content-buffer
                             start-iter
                             end-iter))
            (bytes-ptr (g-malloc (length bytes))))
       (setf (mem-ref length 'g-size) (length bytes))
       (iter (for i from 0 below (length bytes))
             (setf (mem-aref bytes-ptr :uint8 i) (aref bytes i)))
       bytes-ptr)
     (return-from-gtk-text-buffer-serialize-cb () nil))))

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_serialize ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_serialize" %gtk-text-buffer-serialize) :pointer
  (register-buffer (g-object gtk-text-buffer))
  (content-buffer (g-object gtk-text-buffer))
  (format gdk-atom-as-string)
  (start (g-boxed-foreign gtk-text-iter))
  (end (g-boxed-foreign gtk-text-iter))
  (length (:pointer g-size)))

(defun gtk-text-buffer-serialize (register-buffer content-buffer
                                                  format start end)
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[register_buffer]{the GtkTextBuffer format is registered with}
  @argument[content_buffer]{the GtkTextBuffer to serialize}
  @argument[format]{the rich text format to use for serializing}
  @argument[start]{start of block of text to serialize}
  @argument[end]{end of block of test to serialize}
  @argument[length]{return location for the length of the serialized data}
  @return{The serialized data, encoded as format.}
  @begin{short}
    This function serializes the portion of text between start and end in the
    rich text format represented by format.
  @end{short}

  formats to be used must be registered using
  gtk_text_buffer_register_serialize_format() or
  gtk_text_buffer_register_serialize_tagset() beforehand.

  Since 2.10"
  (with-foreign-object (length 'g-size)
    (let ((bytes (%gtk-text-buffer-serialize register-buffer
                                             content-buffer
                                             format
                                             start
                                             end
                                             length)))
      (iter (for i from 0 to (mem-ref length 'g-size))
            (for byte = (mem-aref bytes :uint8 i))
            (collect byte result-type vector)
            (finally (g-free bytes))))))

(export 'gtk-text-buffer-serialize)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_unregister_deserialize_format ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_unregister_deserialize_format"
          gtk-text-buffer-unregister-deserialize-format) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[format]{a GdkAtom representing a registered rich text format.}
  @begin{short}
    This function unregisters a rich text format that was previously registered
    using gtk_text_buffer_register_deserialize_format() or
    gtk_text_buffer_register_deserialize_tagset().
  @end{short}

  Since 2.10"
  (buffer (g-object gtk-text-buffer))
  (format gdk-atom-as-string))

(export 'gtk-text-buffer-unregister-deserialize-format)

;;; ----------------------------------------------------------------------------
;;; gtk_text_buffer_unregister_serialize_format ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_text_buffer_unregister_serialize_format"
          gtk-text-buffer-unregister-serialize-format) :void
 #+cl-cffi-gtk-documentation
 "@version{2013-3-24}
  @argument[buffer]{a GtkTextBuffer}
  @argument[format]{a GdkAtom representing a registered rich text format.}
  @begin{short}
    This function unregisters a rich text format that was previously registered
    using gtk_text_buffer_register_serialize_format() or
    gtk_text_buffer_register_serialize_tagset()
  @end{short}

  Since 2.10"
  (buffer (g-object gtk-text-buffer))
  (format gdk-atom-as-string))

(export 'gtk-text-buffer-unregister-serialize-format)

;;; --- End of file gtk.text-buffer.lisp ---------------------------------------
