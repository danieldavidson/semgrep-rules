class ThingsController < ApplicationController
  def show1
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
  end
end
