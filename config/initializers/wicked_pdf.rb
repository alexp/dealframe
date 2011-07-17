WickedPdf.config = {
  :wkhtmltopdf => Rails.root.join('bin', 'wkhtmltopdf').to_s,
  #:layout => "pdf.html",
  :exe_path => Rails.root.join('bin', 'wkhtmltopdf').to_s
}
