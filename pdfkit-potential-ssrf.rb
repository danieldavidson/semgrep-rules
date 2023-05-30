# PDFKit.new takes the HTML and any options for wkhtmltopdf
# run `wkhtmltopdf --extended-help` for a full list of options
kit = PDFKit.new(html, :page_size => 'Letter')
kit.stylesheets << '/path/to/css/file'

# Get an inline PDF
pdf = kit.to_pdf

# Save the PDF to a file
file = kit.to_file('/path/to/save/pdf')

# PDFKit.new can optionally accept a URL or a File.
# Stylesheets can not be added when source is provided as a URL or File.
kit = PDFKit.new('http://google.com')
kit = PDFKit.new(File.new('/path/to/html'))

PDFKit.new(html).to_pdf

# Add any kind of option through meta tags
PDFKit.new('<html><head><meta name="pdfkit-page_size" content="Letter"')
PDFKit.new('<html><head><meta name="pdfkit-cookie cookie_name1" content="cookie_value1"')
PDFKit.new('<html><head><meta name="pdfkit-cookie cookie_name2" content="cookie_value2"')
