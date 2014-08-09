class VideosController < InheritedResources::Base


  protected
  def resource_params
    return [] if request.get?
    [params.require(:video).permit(:name, :video)]
  end

end
