respond_to do |format|
  format.html
  format.pdf do
    render pdf: "file_name"
  end
end

respond_to do |format|
  format.pdf do
    render :pdf => "my_pdf_name.pdf",
      :disposition => "inline",
      :template => "controller_name/show.pdf.erb",
      :layout => "pdf_layout.html"
  end 

  format.html
end

respond_to do |format|
  format.html
  format.pdf do
  render pdf: [@post.id, @post.name].join('-'),
    template: "posts/show.html.erb",
    formats: [:html],
    disposition: :inline,
    layout: 'pdf'
  end
end

# create a pdf from a string
pdf = WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>')

# create a pdf file from a html file without converting it to string
# Path must be absolute path
pdf = WickedPdf.new.pdf_from_html_file('/your/absolute/path/here')

# create a pdf from a URL
pdf = WickedPdf.new.pdf_from_url('https://github.com/mileszs/wicked_pdf')

# create a pdf from string using templates, layouts and content option for header or footer
pdf = WickedPdf.new.pdf_from_string(
  render_to_string('templates/pdf', layout: 'pdfs/layout_pdf.html'),
  footer: {
    content: render_to_string(
  	  'templates/footer',
  	  layout: 'pdfs/layout_pdf.html'
  	)
  }
)

# It is possible to use footer/header templates without a layout, in that case you need to provide a valid HTML document
pdf = WickedPdf.new.pdf_from_string(
  render_to_string('templates/full_pdf_template'),
  header: {
    content: render_to_string('templates/full_header_template')
  }
)

# or from your controller, using views & templates and all wicked_pdf options as normal
pdf = render_to_string pdf: "some_file_name", template: "templates/pdf", encoding: "UTF-8"

# then save to a file
save_path = Rails.root.join('pdfs','filename.pdf')
File.open(save_path, 'wb') do |file|
  file << pdf
end

# you can also track progress on your PDF generation, such as when using it from within a Resque job
class PdfJob
  def perform
    blk = proc { |output|
      match = output.match(/\[.+\] Page (?<current_page>\d+) of (?<total_pages>\d+)/)
      if match
        current_page = match[:current_page].to_i
        total_pages = match[:total_pages].to_i
        message = "Generated #{current_page} of #{total_pages} pages"
        at current_page, total_pages, message
      end
    }
    WickedPdf.new.pdf_from_string(html, progress: blk)
  end
end
