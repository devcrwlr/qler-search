class Crawler < ApplicationRecord


  def self.new_search(songtitle,singername,lyrics)
    include CrawlerHelper
    require 'open-uri'
    require "rubygems"
    require "nokogiri"
    require 'uri/http'

    search_counter = 10
    lyricsURLArr = []
    googleLinksArr = []
    query = ""

    begin

    if songtitle == "" && singername == "" && lyrics == ""
      return []
    else
      query = "#{songtitle} - #{singername} - #{lyrics} Lyrics"
      #query = "Lovestory - Taylor Swift Lyrics"

      google_search = "https://www.google.fr/search?num=#{search_counter}&q=#{query}"

      uri_escape = URI.escape(google_search)
      doc = Nokogiri::HTML(open(uri_escape, 'User-Agent' => 'firefox'))

        doc.css('div h3 a').each do  |link|
          if link.to_s.include? "/url?q="
               href = link['href'].to_s.gsub("/url?q=","")
               valid_URL = href.split('&sa=')
               googleLinksArr << valid_URL[0]
          end
        end

        return googleLinksArr
    end
  rescue => error
    return error
  end
  end

  def self.get_webcontent(link)
    begin
      require 'open-uri'
      require "rubygems"
      require "nokogiri"

      pagecontent = Nokogiri::HTML(open(link, 'User-Agent' => 'firefox'))

      return getHTMLContent(pagecontent,link)

    rescue => error
      return error
    end
  end

  def self.is_available(link)
    begin
      require 'open-uri'
      require "rubygems"
      require "nokogiri"

      pagecontent = Nokogiri::HTML(open(link, 'User-Agent' => 'firefox'))

      content =  getHTMLContent(pagecontent,link)

      if content.include? "Check link"
        return "Check link"
      elsif content.empty?
        return false
      else
          return true
      end

      return content
    rescue => error
      return error
    end
  end

  def self.validate_page(hashdata)

    title = hashdata[:title]
    pagelyrics = hashdata[:lyrics]
    link = hashdata[:link]
    if title.to_s.include? "404"
      return false
    elsif title.to_s.include? "500"
      return false
    elsif title.to_s.include? "502"
      return false
#    elsif !title.include?(songname)
#      return false
    else

      return hashdata
      #return link
    end
  end


  def self.getHTMLContent(pagelyrics,thelyrics)
    require 'rubygems'
    require 'htmlentities'

      begin

         if thelyrics.include? "lyricsmode.com"
           lyricscontent = pagelyrics.css('div.inner-song-page-content p#lyrics_text')

         elsif thelyrics.include? "coveralia.com"
           lyricscontent = pagelyrics.css('div#HOTWordsTxt')

         elsif thelyrics.include? "justsomelyrics.com"
           lyricscontent = pagelyrics.css('div.content p')
           lyricscontent.search('a').each do |sp|
             sp.remove
           end

         elsif thelyrics.include? "songtexte.com"
           lyricscontent = pagelyrics.css('div#lyrics')

         elsif thelyrics.include? "lyricsfreak.com"

           lyricscontent = pagelyrics.css('div#content_h')

         elsif thelyrics.include? "azlyrics.com"

           lyricscontent = pagelyrics.css('div.text-center div')
           lyricscontent = lyricscontent.css('div')[7]

         elsif thelyrics.include? "genius.com"

           lyricscontent = pagelyrics.css('div.lyrics p')

         elsif thelyrics.include? "metrolyrics.com"

           lyricscontent = pagelyrics.css('div#lyrics-body-text p.verse')

         elsif thelyrics.include? "songlyrics.com"

           lyricscontent = pagelyrics.css('div#songLyricsDiv-outer p#songLyricsDiv')

         elsif thelyrics.include? "musixmatch.com"

             lyricscontent = pagelyrics.css('div.mxm-lyrics p.mxm-lyrics__content')

         elsif thelyrics.include? "lyrics.az"

           lyricscontent = pagelyrics.css('div p.lyric-text')

         elsif thelyrics.include? "unilyrics.com"

           lyricscontent = pagelyrics.css('div.entry-content p')

         elsif thelyrics.include? "videokeman.com"

           lyricscontent = pagelyrics.css('div.art-post-inner p')

         elsif thelyrics.include? "gugalyrics.com"

           lyricscontent = pagelyrics.css('div.content')

         elsif thelyrics.include? "azlyricdb.com"

           lyricscontent = pagelyrics.css('div#lrc')

         elsif thelyrics.include? "stlyrics.com"

           lyricscontent = pagelyrics.css('div.main-text')

         elsif thelyrics.include? "elyrics.net"

           lyricscontent = pagelyrics.css('div#inlyr')

         elsif thelyrics.include? "lyricspinas.com"

           lyricscontent = pagelyrics.css('div.post-body')

         elsif thelyrics.include? "smule.com"

           lyricscontent = pagelyrics.css('div.lyrics p')

         elsif thelyrics.include? "opmtunes.com"

           lyricscontent = pagelyrics.css('pre')
           lyricscontent.search('span.c1').each do |sp|
             sp.remove
           end
           lyricscontent.search('span.c2').each do |sp|
             sp.remove
           end

         elsif thelyrics.include? "exposedlyrics.com"

           lyricscontent = pagelyrics.css('div.entry-content')

         elsif thelyrics.include? "rebelpixel.com"

           lyricscontent = pagelyrics.css('div.entry')


         elsif thelyrics.include? "lyricsera.com"

           lyricscontent = pagelyrics.css('div.lyric')

         elsif thelyrics.include? "mojim.com"

           lyricscontent = pagelyrics.css('div.fsZ dl.fsZx1')

         elsif thelyrics.include? "lyricsroot.com"

           lyricscontent = pagelyrics.css('div.texts p')

         elsif thelyrics.include? "lyricsreg.com"

           lyricscontent = pagelyrics.css('section#maincontent div')
           lyricscontent = lyricscontent.at_css('[style="text-align:center"]')
           lyricscontent.search('h2.content-subhead').remove
           lyricscontent.search('div.lyrics_above_ad').remove
           lyricscontent.search('div.below_lyrics_ad').remove
           lyricscontent.search('div.lyrics_below_ad2').remove
           lyricscontent.search('a.pure-button').remove

          elsif thelyrics.include? "lyrics.com"

           lyricscontent = pagelyrics.css('pre#lyric-body-text')

         elsif thelyrics.include? "lyricsprint.com"

           lyricscontent = pagelyrics.css('div.entry p')

          elsif thelyrics.include? "originalpinoylyrics.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body')
           lyricscontent.search('div.separator').remove

         elsif thelyrics.include? "flashlyrics.com"

           lyricscontent = pagelyrics.css('div.main-panel-coDEDEDntent span')

         elsif thelyrics.include? "tagaloglang.com"

           lyricscontent = pagelyrics.css('div.entry-content p')

         elsif thelyrics.include? "nitrolyrics.com"

           lyricscontent = pagelyrics.css('div.lyric p')

         elsif thelyrics.include? "justsomelyrics.com"

           lyricscontent = pagelyrics.css('div.content')
           lyricscontent.search('a').remove

         elsif thelyrics.include? "lyriczz.com"

           lyricscontent = pagelyrics.css('div.lyriczz')
           lyricscontent.search('a').remove
           lyricscontent.search('script').remove

         elsif thelyrics.include? "lyrics.wikia.com"

           lyricscontent = pagelyrics.css('div.lyricbox')

         elsif thelyrics.include? "liryko.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body div')[5]

         elsif thelyrics.include? "lyricsok.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body div div')
           lyricscontent.search('a').remove
           lyricscontent.search('h1').remove

         elsif thelyrics.include? "allthelyrics.com"

           lyricscontent = pagelyrics.css('div.content-text-inner p')

         elsif thelyrics.include? "pinoylyrics.net"

           lyricscontent = pagelyrics.css('div.col-md-6 p')

         elsif thelyrics.include? "idatekira.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body div')

         elsif thelyrics.include? "citilyrics.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body')
           lyricscontent.search('a').remove
           lyricscontent.search('u').remove
           lyricscontent.search('div.box-admin').remove

         elsif thelyrics.include? "testicanzoni.mtv.it"

           lyricscontent = pagelyrics.css('div.testo p')
           lyricscontent.search('a').remove
           lyricscontent = lyricscontent.to_s.gsub("</p>","")
           lyricscontent = lyricscontent.to_s.gsub("<p>","\n")

         elsif thelyrics.include? "letssingit.com"

           lyricscontent = pagelyrics.css('div.contentbox')

         elsif thelyrics.include? "kantangnoypi.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body div')
           lyricContent = lyricscontent.search('[style="text-align: center;"]')
           lyricscontent.search('span').remove

         elsif thelyrics.include? "chordie.com"

           lyricscontent = pagelyrics.css('div#firstcol div')
           lyricscontent.search('span.relc').remove
           lyricscontent.search('span.bracket').remove
           lyricscontent.search('span.inlc').remove
           lyricscontent = lyricscontent.to_s.gsub("</div>","")
           lyricscontent = lyricscontent.to_s.gsub("<div class=\"textline\">","\n")
           lyricscontent = lyricscontent.to_s.gsub("<div class=\"chordline\">","\n")

         elsif thelyrics.include? "lyricsmint.com"

           lyricscontent = pagelyrics.css('div#lyric p')

         elsif thelyrics.include? "indicine.com"

           lyricscontent = pagelyrics.css('div.entry-content p')

         elsif thelyrics.include? "lyricsted.com"

           lyricscontent = pagelyrics.css('div.lyric-content p')

         elsif thelyrics.include? "lyricsoye.com"

           lyricscontent = pagelyrics.css('article.lyrics-content-box')

         elsif thelyrics.include? "lyricsmasti.com"

           lyricscontent = pagelyrics.css('div.col-md-7 code')

         elsif thelyrics.include? "lyricsraag.com"

           lyricscontent = pagelyrics.css('div.su-column-inner p')

         elsif thelyrics.include? "lyricstashan.com"

           lyricscontent = pagelyrics.css('div.col-xs-6')
           lyricscontent.search('div.pin-wrapper').remove

         elsif thelyrics.include? "sujiwotejo.com/"

           lyricscontent = pagelyrics.css('div.post-entry')

         elsif thelyrics.include? "laguaz.net"

           lyricscontent = pagelyrics.css('div#lyrics-tab div.fn-container')

         elsif thelyrics.include? "everyshalalala.wordpress.com"

           lyricscontent = pagelyrics.css('div.entry-content p')
           lyricscontent = lyricscontent.to_s.gsub("<em>","\n")
           lyricscontent = lyricscontent.to_s.gsub("</em>","\n")
           lyricscontent = lyricscontent.to_s.gsub("<strong>","\n")
           lyricscontent = lyricscontent.to_s.gsub("</strong>","\n")

         elsif thelyrics.include? "lirikindieindonesia.blogspot.co.id"

           lyricscontent = pagelyrics.css('div.post-body div')

         elsif thelyrics.include? "lirik.web.id"

           lyricscontent = pagelyrics.css('div.entry-content p')

         elsif thelyrics.include? "tiotrina-trac.blogspot.co.id"

           lyricscontent = pagelyrics.css('div.post-body')

         elsif thelyrics.include? "meta-purnama.blogspot.co.id"

           lyricscontent = pagelyrics.css('div.post-body span')

         elsif thelyrics.include? "lirik.cc"

           lyricscontent = pagelyrics.css('span.disable-lyric p')

         elsif thelyrics.include? "songmeanings.com"

           lyricscontent = pagelyrics.css('div.lyric-box')
           lyricscontent.search('div a').remove

         elsif thelyrics.include? "musiklib.org"

           lyricscontent = pagelyrics.css('div#song-lyric')
           lyricscontent.search('div.x-12').remove
           lyricscontent.search('div#song-other-lyrics').remove

         elsif thelyrics.include? "diliriklagu.com"

           lyricscontent = pagelyrics.css('div.entry-content')

         elsif thelyrics.include? "liriklaguxd.blogspot.com"

           lyricscontent = pagelyrics.css('div.post-body p')

         elsif thelyrics.include? "carapedia.com"

           lyricscontent = pagelyrics.css('div.generic-content')

         elsif thelyrics.include? "liriklagu.co.id"

           lyricscontent = pagelyrics.css('div.col-sm-8 div p')

         elsif thelyrics.include? "pandoraboxid.blogspot.co.id"

           lyricscontent = pagelyrics.css('div.post-body div')
           lyricscontent.search('div.postmeta a').remove

         elsif thelyrics.include? "kontenlirik.blogspot.co.id"

           lyricscontent = pagelyrics.css('div.post-body div')

         elsif thelyrics.include? "lyricxmusic.blogspot.co.id"

           lyricscontent = pagelyrics.css('article.post-outer-container div.post-outer div.post-content div.post-body-container div.post-body')

         elsif thelyrics.include? "lyricsmania.com"

           lyricscontent = pagelyrics.css('div.p402_premium')

         elsif thelyrics.include? "lyric.tkaraoke.com"

           lyricscontent = pagelyrics.css('div.div-content-lyric')

         elsif thelyrics.include? "mp3.zing.vn"

           lyricscontent = pagelyrics.css('div.fn-container p.fn-wlyrics')

         elsif thelyrics.include? "karahd.com"

           lyricscontent = pagelyrics.css('div.lyric div.entry-content p')

         elsif thelyrics.include? "keeng.vn"

           lyricscontent = pagelyrics.css('div.wrap-lyric-audio div.info-show p')

         elsif thelyrics.include? "hatkaraoke.vn"

           lyricscontent = pagelyrics.css('div.lyric p')

         elsif thelyrics.include? "nhac.vn"

           lyricscontent = pagelyrics.css('div.content_lyrics')
           lyricscontent.search('div a.btn-exp').remove

         else
             lyricscontent = "Check link"

        end

              formattedLyrics= ""
          if lyricscontent.to_s.include?("Check Link")
              formattedLyrics = lyricscontent
          else
              lyricstxt = lyricscontent.to_s.gsub("<br>","\r\n")
              lyricstxt = Nokogiri::HTML(lyricstxt)
              formattedLyrics = lyricscontent
          end

          # if formattedLyrics.size <= 30000
          #   #saveTxtFile(formattedLyrics,thelyrics,songlist,link_counter)
          #   lyricsInfo = {
          #      link: thelyrics,
          #      lyrics: formattedLyrics
          #    }
          #
          # end
          return HTMLEntities.new.decode lyricscontent

     rescue => error
          puts "Unable to Download Lyrics #{error}"
     end

   end

end
