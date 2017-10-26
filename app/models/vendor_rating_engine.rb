class VendorRatingEngine

  def self.vendor_rating_scope
    RatingFactorSummary.where(rateable_type: "Site")
  end

  def self.get_vendors_rating
    vendor_rating_scope.group("rateable_id").select("sum(rating) as rating,rateable_id")
  end

  def self.get_vendor_rating(vendor_id)
    vendor_rating_scope.where(rateable_id: vendor_id)
  end

  def self.recompute_rating(options)
    ts = options[:recompute_time_span]
    Rating.created_at_gt(eval(ts)).
  end

  def compute_rating()
    r= self.rating#bind rating obj to engine somehow
    rf = r.rating_factor
    rf.
  end
end