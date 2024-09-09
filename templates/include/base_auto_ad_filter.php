

        <a href="/catalog/<?php echo  $car['mark_name'] . '/' . $car['model_id'] . '/'. $car['year-start'];?>/" class="col-md-3" >
            <div class="item-grid" >
                <div class="item-grid-img">
                    <img loading="lazy" class="image-autofocus ad-gallery-hover-slider-image" data-src="<?php echo Exists($config["media"]["car_photos"], $car['img'].".jpg", $config["media"]["no_image"]);?>" src="<?php echo Exists($config["media"]["car_photos"], $car['img'].".jpg", $config["media"]["no_image"]);?>" alt="Car_photo">
                </div>
                
                <div class="item-grid-info" >                
                    <strong style="color:#000;"><?php echo $car['mark_name'].' '.$car['model_name'].' '.$car['year-start'].'-' ;?><?php if($car['year-stop']) echo $car['year-stop']; else echo '...';?></strong>
                    <span><?php if($car['generation_name']) echo $car['generation_name']; else  echo '-'; ;?>  </span>
                    <p style="color:#000;"><?php echo $car['body-type'];?></p> 
                </div>
            </div>
        </a>
