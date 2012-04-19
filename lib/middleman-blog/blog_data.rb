module Middleman
  module Blog
    # A store of all the blog articles in the site, with accessors
    # for the articles by various dimensions. Accessed via "blog" in
    # templates.
    class BlogData

      # @private
      def initialize(app)
        @app = app
        @sitemap = @app.sitemap
        @_articles = []
      end

      # A list of all blog articles, sorted by date
      # @return [Array<Middleman::Extensions::Blog::BlogArticle>]
      def articles
        @_sorted_articles ||= begin
          @_articles.sort do |a, b|
            b.date <=> a.date
          end
        end
      end

      # The BlogArticle for the given path, or nil if one doesn't exist.
      # @return [Middleman::Extensions::Blog::BlogArticle]
      def article(path)
        @sitemap.find_resource_by_destination_path(path.to_s)
      end

      # Returns a map from tag name to an array
      # of BlogArticles associated with that tag.
      # @return [Hash<String, Array<Middleman::Extensions::Blog::BlogArticle>>]
      def tags
        @_tags ||= begin
          tags = {}
          @_articles.each do |article|
          article.tags.each do |tag|
              tags[tag] ||= []
              tags[tag] << article
            end
          end

          tags
        end
      end

      # Update the main sitemap resource list
      # @return [void]
      def manipulate_resource_list(resources)
        # Clear caches
        @_articles = []
        
        # Loop through existing resource, replace Resources with BlogArticles
        
        # @_articles <<
        
        resources
      end
      
      # sitemap.reroute do |destination, page|
      #   if page.path =~ path_matcher
      #     # This doesn't allow people to omit one part!
      #     year = $1
      #     month = $2
      #     day = $3
      #     title = $4
      # 
      #     # compute output path:
      #     #   substitute date parts to path pattern
      #     #   get date from frontmatter, path
      #     blog_permalink.
      #       sub(':year', year).
      #       sub(':month', month).
      #       sub(':day', day).
      #       sub(':title', title)
      #   else
      #     destination
      #   end
      # end
      
      # 
      # app.ready do
      #   # Set up tag pages if the tag template has been specified
      #   if defined? blog_tag_template
      #     page blog_tag_template, :ignore => true
      # 
      #     blog.tags.each do |tag, articles|
      #       page tag_path(tag), :proxy => blog_tag_template do
      #         @tag = tag
      #         @articles = articles
      #       end
      #     end
      #   end
      # 
      #   # Set up date pages if the appropriate templates have been specified
      #   blog.articles.group_by {|a| a.date.year }.each do |year, year_articles|
      #     if defined? blog_year_template
      #       page blog_year_template, :ignore => true
      # 
      #       page blog_year_path(year), :proxy => blog_year_template do
      #         @year = year
      #         @articles = year_articles
      #       end
      #     end
      #     
      #     year_articles.group_by {|a| a.date.month }.each do |month, month_articles|
      #       if defined? blog_month_template
      #         page blog_month_template, :ignore => true
      # 
      #         page blog_month_path(year, month), :proxy => blog_month_template do
      #           @year = year
      #           @month = month
      #           @articles = month_articles
      #         end
      #       end
      #       
      #       month_articles.group_by {|a| a.date.day }.each do |day, day_articles|
      #         if defined? blog_day_template
      #           page blog_day_template, :ignore => true
      # 
      #           page blog_day_path(year, month, day), :proxy => blog_day_template do
      #             @year = year
      #             @month = month
      #             @day = day
      #             @articles = day_articles
      #           end
      #         end
      #       end
      #     end
      #   end
      # end
    end
  end
end
