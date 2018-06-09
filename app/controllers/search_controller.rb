class SearchController < ApplicationController
    include CrawlerHelper

  def search

      lyricsURLArr = []
      arrResult = []
      txtInput = ""
      lyrics = Crawler.new_search(params[:songtitle],params[:singername],params[:lyrics])
      lyrics.each do |link|

          unless validateLinks(link,lyricsURLArr) == false
              if params[:songtitle].present?
                song = "SongName"
              end
              if params[:singername].present?
                singer = "SingerName"
              end
              if params[:lyrics].present?
                lyric = "Lyrics"
              end
               hashInput = {
                 songname: song,
                 singername: singer,
                 lyrics: lyric,
                 link: link
               }

            lyricsURLArr << hashInput
          end

      end

      @result = lyricsURLArr

      if @result
        respond_to do |format|
          format.js { render partial: 'search/test' }
        end
      end

  end

  def saved
    radiobtnValue = params[:radios1]

    @saved = radiobtnValue

      respond_to do |format|
        format.js { render partial: 'search/saved' }
      end

  end

  def paramsName(name,value)
    if value.empty?
      name = ""
    end
    return name
  end

end
