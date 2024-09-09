<div class="col-md-3"> 
	<a href="/catalog/<?php echo $car['mark']['name'] . '/' . $car['id'];?>/" class="item-grid" > 
		<div class="item-grid-img-base" >
			<img loading="lazy" data-src="<?php echo Exists($config["media"]["car_photos"], $car['configuration'][0][0]['id'].".jpg", $config["media"]["no_image"]);?>" src="<?php echo Exists($config["media"]["car_photos"], $car['configuration'][0][0]['id'].".jpg", $config["media"]["no_image"]);?>" alt="Car_photo">			
            <div class="item-grid-inf-base">
                <strong><?php echo  $car['mark']['name'] . ' ' . $car['name'];?></strong>                 
            </div> 
		</div>	        			
    </a>
</div>

