class VendorRatingEngine
  cattr_accessor :rating_type

  def self.vendor_rating_scope
    RatingFactorSummary.where(rateable_type: "Site")
  end

  def self.get_vendors_rating
    RatingFactorSummary.group(:rateable_id).map(&:rateable_id).map do |rateable_id|
      {rateable_id: rateable_id,rating: get_vendor_rating(rateable_id)[:rating]}
      get_vendor_rating(rateable_id).slice(:rateable_id,:rating)
    end
  end

  def weighted_rating
    vendor_rating_scope.joins(:rating_factor).group("rating_factor_summaries.rateable_id").select("sum(rating_factor_summaries.rating*rating_factors.weightage)/100 as ratingss,rateable_id")
  end

  def self.get_vendor_rating(vendor_id)
    # result = {}
    # overall_rating = (RatingFactor.where(parent_id: nil).map do |rf|
    #   result[rf.code]=((rf.immediate_children.map do |c|
    #     c.rating_factor_summaries.where(rateable_id: vendor_id, rateable_type: "Site").first.rating * c.weightage
    #   end.sum)/100.0)
    #   result[rf.code]*rf.weightage
    # end.sum)/100.0
    # *****for two dimensions****************
    @rating_split_up = {}
    root_rating_factor = RatingFramework.find_by_name("vendor_rating").root_rating_factor
    rating = summarized_rating(root_rating_factor, vendor_id)/100.0
    {rating: rating, rating_split_up: @rating_split_up, vendor_id: vendor_id, vendor_name: Site.find(vendor_id).name}
  end

  def self.recompute_rating(options)
    ts = options[:recompute_time_span]
    Rating.created_at_gt(eval(ts))
  end

  def compute_rating()
    r= self.rating#bind rating obj to engine somehow
    rf = r.rating_factor
    # rf.
  end

  def self.summarized_rating(rating_factor, vendor_id)
    if rating_factor.immediate_children.empty?
      rating_factor.rating_factor_summaries.find_by_rateable_id_and_rateable_type(vendor_id,"Site").try(:rating).to_f * rating_factor.weightage
    else
      res = ((rating_factor.immediate_children.map do |rfc|
        summarized_rating(rfc, vendor_id)
      end.sum)/100.0) 
      @rating_split_up[rating_factor.code] = res if (rating_factor.level == 1)
      res * rating_factor.weightage
    end
  end

end