<?php 
	$images = $Ads->getImages($value["ads_images"]);
	$service = $Ads->adServices($value["ads_id"]);
	$getShop = $Shop->getUserShop($value["ads_id_user"]);
	
	$ads_id = $value['ads_id'];
	$filters = [
	'312' => 'query_1',
	'310' => 'query_2',
	'314' => 'query_3',];
	foreach ($filters as $filterId => $varName) {$$varName = getAll("SELECT ads_filters_variants_product_id, ads_filters_variants_val FROM uni_ads_filters_variants WHERE ads_filters_variants_product_id = $ads_id AND ads_filters_variants_id_filter = $filterId;");}
	
?>
<div class="col-lg-6 col-md-6 col-sm-6 col-6" >
	<div class="item-grid <?php echo $service[2] || $service[3] ? "ads-highlight" : ""; ?>" title="<?php echo $value["ads_title"]; ?>" >
		<div class="item-grid-img" >
			<a href="<?php echo $Ads->alias($value); ?>" title="<?php echo $value["ads_title"]; ?>" >
				
				<div class="item-labels" >
					<?php echo $Ads->outStatus($service, $value); ?>
				</div>
				
				<?php echo $Ads->CatalogOutAdGallery($images, $value); ?>
				
			</a>
			<?php echo $Ads->adActionFavorite($value, "catalog", "item-grid-favorite"); ?>
		</div>
		<div class="item-grid-info" >
			
			<div class="item-grid-price" >
				<?php
					echo $Ads->outPrice( [ "data"=>$value,"class_price"=>"item-grid-price-now","class_price_old"=>"item-grid-price-old", "shop"=>$getShop, "abbreviation_million" => true ] );
				?>        
			</div>
			<a href="<?php echo $Ads->alias($value); ?>" ><?php
				$datas = custom_substr($value["ads_title"], 35, "...");
				$parts = explode(" ", $datas);
				
				for ($i = 0; $i <= min(count($parts), 100); $i++) {
					echo '<span class="tag' . $i . '"> '.$ULang->t($parts[$i], ["table" => "uni_ads_filters", "field" => "ads_filters_items_value"]).' </span>';
				}
			?></a>
		</div>
	</div>
</div>