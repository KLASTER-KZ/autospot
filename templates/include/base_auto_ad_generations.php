<h2 class="title-and-link h4" style="font-size:30px; margin-bottom: 30px;font-weight: 900;"><?php echo $ULang->t("Модельный ряд"); ?> <?php echo $cars['mark']['name'].' '.$cars['name'];?></h2>

<div class="row no-gutters gutters10">
    <?php foreach($cars['generation'] as $key => $car){?>
        <a href="/catalog/<?php echo  $cars['mark']['name'] . '/' . $cars['id'] . '/'. $car['year-start'];?>/" class="col-md-3" >
            <div class="item-grid" >
                <div class="item-grid-img">
                    <img loading="lazy" class="image-autofocus ad-gallery-hover-slider-image" data-src="<?php echo Exists($config["media"]["car_photos"], $cars['configuration'][$key][0]['id'].".jpg", $config["media"]["no_image"]);?>" src="<?php echo Exists($config["media"]["car_photos"], $cars['configuration'][$key][0]['id'].".jpg", $config["media"]["no_image"]);?>" alt="Car_photo">
                </div>
                
                <div class="item-grid-info" >                
                    <strong style="color:#000;"><?php echo $cars['mark']['name'].' '.$cars['name'].' '.$car['year-start'].'-' ;?><?php if($car['year-stop']) echo $car['year-stop']; else echo '...';?></strong>
                    <span><?php echo $car['name'];?></span>
                    <p style="color:#000;"><?php echo $cars['configuration'][$key][0]['body-type'];?></p> 
                </div>
            </div>
        </a>
    <?php }?>
</div>

