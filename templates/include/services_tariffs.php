<?php if ($value["services_ads_uid"]) { ?>
	<div class="ads-services-tariffs" data-id="<?php echo $value["services_ads_uid"]; ?>" data-id="3">
	<?php
	$conn = new mysqli($config["db"]["host"], $config["db"]["user"], $config["db"]["pass"], $config["db"]["database"]);
	$conn->set_charset("utf8");
	$sql = "SELECT sign FROM uni_currency WHERE main = 1";
	$result = $conn->query($sql);
	?>
	<?php if ($value["services_ads_recommended"]) { ?>
		<span class="ads-services-tariffs-discount">
			<?php echo $ULang->t("Рекомендуем"); ?>
		</span>
	<?php } ?>

	<div class="ads-services-tariffs-icon">
		<span> <img
				src="<?php echo Exists($config["media"]["other"], $value["services_ads_image"], $config["media"]["no_image"]); ?>"
				height="55"> </span>
	</div>
	<p class="services_ads_name">
		<strong style="<?php if($value["services_ads_uid"] == 3){echo "font-size:32px";}?>">
			<?php echo $ULang->t($value["services_ads_name"], ["table" => "uni_services_ads", "field" => "services_ads_name"]); ?>
		</strong>
		<span>
			<?php
			if($value["services_ads_uid"] == 3){
				echo $ULang->t('в 30 раз больше просмотров');
			} else if($value["services_ads_uid"] == 2){
				echo $ULang->t('в 10 раз больше просмотров');
			}

			?>
		</span>
	</p>
	<?php if ($value["services_ads_variant"] == 1) { ?>
		<p style="display:none;">
			<?php echo $ULang->t("Действует"); ?> <span id="services_ads_count_day<?php echo $value["services_ads_uid"]; ?>">
				<?php echo $value["services_ads_count_day"]; ?>
			</span>
			<?php echo $ULang->t("дней"); ?>
		</p>
	<?php } else { ?>
		<div class="input-group input-group-sm">
			<input type="number" class="form-control" name="service[<?php echo $value["services_ads_uid"]; ?>]"
				id="services-ads-count-<?php echo $value["services_ads_uid"]; ?>" value="1">
			<div class="input-group-append">
				<span class="input-group-text">
					<?php echo $ULang->t("дней"); ?>
				</span>
			</div>
		</div>
	<?php } ?>
	<p class="services_ads_description services_ads_description<?php echo $value["services_ads_uid"]; ?>">
		<?php echo $ULang->t($value["services_ads_text"], ["table" => "uni_services_ads", "field" => "services_ads_text"]); ?>
	</p>
	<?php echo $Main->outPrices(array("new_price" => array("price" => $value["services_ads_new_price"], "tpl" => '<p class="ads-services-tariffs-price-now" > <strong></strong> </p>'), "price" => array("price" => $value["services_ads_price"], "tpl" => '<p class="ads-services-tariffs-price-old" ><span>{price}</span></p>'))); ?>
	
	<strong>
		<p class="ads-services-tariffs-price-now"><span id="total-price-<?php echo $value["services_ads_uid"]; ?>">
				<?php echo $value["services_ads_new_price"] ? $value["services_ads_new_price"] : $value["services_ads_price"]; ?>
			</span>
			<?php if ($result->num_rows > 0) {
				while ($row = $result->fetch_assoc()) {
					echo "" . $row["sign"];
				}
			} ?>
		</p>
	</strong>

	<?php if($value["services_ads_new_price"] != 0){?>

		<p class="action_services_ads">
			<?php echo $ULang->t("Экономия "); ?>
			<?php echo ($value["services_ads_price"] - $value["services_ads_new_price"]);?> ₾
		</p>

	<?php }?>

	<button class="services_ads_btn">
		<?php 
		echo $ULang->t("Подключить за");
		echo " "; 
		echo $value["services_ads_new_price"] ? $value["services_ads_new_price"] : $value["services_ads_price"]; 
		?>
		 ₾ 
	</button>
	
	<!-- <script>
		document.getElementById('services-ads-count-<?php echo $value["services_ads_uid"]; ?>').addEventListener('change', function () {
			var count = parseInt(this.value);
			var price = <?php echo $value["services_ads_price"]; ?>;
			var totalPrice = price * count;
			document.getElementById('total-price-<?php echo $value["services_ads_uid"]; ?>').textContent = totalPrice;
		});
	</script> -->
</div>

<?php }else{ ?>

	<div class="ads-services-tariffs" data-id="<?php echo $value["services_ads_uid"]; ?>">
            <p class="services_ads_name">
                <strong><?php echo $ULang->t("Обычное объявление"); ?></strong>
                <span><?php echo $ULang->t("30 дней бесплатно"); ?></span>
            </p>		
            <div class="tariffs_free-box">
            <?php
                $getCategory = getAll("SELECT * FROM uni_services_ads_category order by id asc");
                                
                if(count($getCategory)){
                    foreach ($getCategory as $value) {
                        if($value['visible'] == 1){
                    ?>											
                        <div class="tariffs_free-block">
                            <img style="width: 32px; height: 32px;" src="<?php echo Exists( $config["media"]["other"],$value["image"],$config["media"]["no_image"] ); ?>" alt="<?php echo $value['name']; ?>">
                            <span style="flex-grow: 1;"><?php echo $ULang->t($value["text"]); ?></span>
                            <span class="tariffs_free-price"><?php echo $value["price"] ?>₾</span>
                            <div class="tariffs_free-checkbox">													
                                <input value="<?php echo $value["price"] ?>" type="checkbox" id="tariffs_free-checkbox<?php echo $value["id"]; ?>" name="tariffs_free-checkbox<?php echo $value["id"]; ?>"/><label for="tariffs_free-checkbox<?php echo $value["id"]; ?>">Toggle</label>
                            </div>
                        </div>
                    <?php
                        }
                    }
                }
            ?>	
            </div>																
            <div class="free_action_btn"><?php echo $ULang->t("Опубликовать без продвижения"); ?></div>
            <button class="services_ads_btn free_action_btn_sub" style="display:none;">
			<?php echo $ULang->t("Подключить за "); ?><span id="price_free"></span> ₾ 
            </button>
        </div>

<?php } ?>