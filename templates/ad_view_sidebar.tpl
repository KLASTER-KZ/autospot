<div class="board-view-right" >
	<div class="board-view-sidebar-box" id="board-view-sidebar-box">
 		<div class="board-view-sidebar" id="board-view-sidebar">
		<?php
		
			function getCurrencyRate($fromCurrency, $toCurrency) {
				$cacheDir = "./cache";
				if (!is_dir($cacheDir)) {
					mkdir($cacheDir, 0755, true);
				}
				
				$cacheFile = "$cacheDir/$fromCurrency-$toCurrency.json";
				$cacheTime = 3600; // 1 час
				
				if (file_exists($cacheFile) && (time() - filemtime($cacheFile) < $cacheTime)) {
					$data = file_get_contents($cacheFile);
					} else {
					$url = "https://api.exchangerate-api.com/v4/latest/$fromCurrency";
					$curl = curl_init($url);
					curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
					$data = curl_exec($curl);
					curl_close($curl);
					
					if ($data) {
						file_put_contents($cacheFile, $data);
					}
				}
				$exchangeRate = 1.0; // Default value in case of an error or missing data
				$rates = json_decode($data, true);
				if (isset($rates['rates'][$toCurrency])) {
					$exchangeRate = $rates['rates'][$toCurrency];
				}
				
				return $exchangeRate;
			}
			
			$eurToLari = getCurrencyRate('EUR', 'GEL');
			$uahToLari = getCurrencyRate('UAH', 'GEL');
			$kztToLari = getCurrencyRate('KZT', 'GEL');
			$rubToLari = getCurrencyRate('RUB', 'GEL');
			$amdToLari = getCurrencyRate('AMD', 'GEL');
			$tryToLari = getCurrencyRate('TRY', 'GEL');
			$aznToLari = getCurrencyRate('AZN', 'GEL');
			$kgsToLari = getCurrencyRate('KGS', 'GEL');
			$uzsToLari = getCurrencyRate('UZS', 'GEL');
			$usdToLari = getCurrencyRate('USD', 'GEL');
		?>
		
		<div class="board-view-price-box" style="display: flex; align-items: center; width: 100%;justify-content: space-between; flex-wrap: wrap;position: relative;">
			<div class="board-view-price price-currency" style="display: flex; align-items: center;gap: 2px; ">        
				<?php
					echo $Ads->outAdViewPrice(["data" => $data["ad"]]);
				?>
				<div style="float: left;"></div> 
				<i id="angle-down-icon" class="las la-angle-down"></i>   
			</div>
			<div id="inf_customs" class="inf_customs"></div>
            <div class="board-view-price-currency" style="display: none;">
					<h5 class="ad-view-subtitle-bold" style="font-size: 17px;">
						<div class="mt5"> <?php echo  $Main->adPrefixPrice($Main->price($data["ad"]["ads_price"],$param["data"]["ads_currency"]),$param["data"])?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $eurToLari, 0, '.', ',') . ' €'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $kztToLari, 0, '.', ',') . ' ₸'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $uahToLari, 0, '.', ',') . ' ₴'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $rubToLari, 0, '.', ',') . ' ₽'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $amdToLari, 0, '.', ',') . ' ֏'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $tryToLari, 0, '.', ',') . ' ₺'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $aznToLari, 0, '.', ',') . ' ₼'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $kgsToLari, 0, '.', ',') . ' лв'; ?></div>
						<div class="mt5"> <?php echo number_format($data["ad"]["ads_price"] / $uzsToLari, 0, '.', ',') . ' soʻm'; ?></div>
					</h5>
					<script>
						
						var adsBargain = <?php echo $data["ad"]["ads_bargain"]; ?>; // Если значение получено из PHP
						var adsPriceFree = <?php echo $data["ad"]["ads_price_free"]; ?>; // Если значение получено из PHP
						
						if (adsBargain === 1 || adsPriceFree === 1) {
							document.getElementById("angle-down-icon").style.display = "none";
						}
					</script>
					
				</div>  
		</div>          

        <?php echo $Ads->adSidebar($data);?>

		
	</div>
 	</div>
        
    <div class="board-view-user" >
		
		<?php echo $Profile->cardUser($data); ?>
		
	</div>		
	
	
	
	<div class="view-list-status-box" >
		<?php
			if($data["ad"]["ads_auction"]){
			?>
			<div class="view-list-status-promo ad-view-promo-status-auction" >
				
				<h5><?php echo $ULang->t("Аукцион"); ?></h5>
				
				<?php echo $Ads->adAuctionSidebar( $data ); ?>
				
			</div>
			<?php
			}
			
			if($data["ad"]["ads_booking"]){
			?>
			<div class="view-list-status-promo ad-view-promo-status-booking" >
				
				<div class="row" >
					<div class="col-lg-3 col-3" >
						
						<img src="/media/others/86155-play-video-rewind-repeat.svg" style=" width: 75px; "/>
						
					</div>
					<div class="col-lg-9 col-9" >
						
						<h5><?php echo $ULang->t("Онлайн-аренда"); ?></h5>
						
						<?php if($data["ad"]["category_board_booking_variant"] == 0){ ?>
							
							<?php }else{ ?>
							<p><?php echo $ULang->t("Можно взять в аренду онлайн"); ?></p>
						<?php } ?>
						
					</div>
				</div>
				
			</div>
			<?php
			}
			
			if($data["ad"]["ads_online_view"]){
			?>
			<div class="view-list-status-promo ad-view-promo-status-online" >
				
				<div class="row" >
					<div class="col-lg-3 col-3" >
						
						<img src="/media/others/86155-play-video-rewind-repeat.svg" style="width: 75px;"/>
						
					</div>
					<div class="col-lg-9 col-9" >
						
						<h5><?php echo $ULang->t("Онлайн-показ"); ?></h5>

						<span class="view-list-status-promo-button open-modal" data-id-modal="modal-ad-online-view" ><?php echo $ULang->t("Подробнее"); ?> <i class="las la-arrow-right"></i></span>
						
					</div>
				</div>
				
			</div>
			<?php
			}  
			
		?>
	</div>
	
	<?php if( $data["ad"]["ads_status"] != 0 ){ ?>
		
		<?php if($_SESSION["profile"]["id"] == $data["ad"]["ads_id_user"]){ ?>
			<div class="board-view-sidebar-box-stimulate" >
				
				<p class="box-stimulate-title" ><?php echo $ULang->t("Кол-во показов"); ?></p>
				
				<p class="box-stimulate-count" ><?php echo $Ads->getDisplayView($data["ad"]["ads_id"], date("Y-m-d")); ?></p>
				
				<?php if( !$data["order_service_ids"] && $data["ad"]["ads_status"] == 1 && strtotime($data["ad"]["ads_period_publication"]) > time() ){ ?>
					<span class="btn-custom-mini btn-color-blue mt10 open-modal" data-id-modal="modal-top-views" ><?php echo $ULang->t("Как повысить?"); ?></span> 
				<?php } ?>
				
			</div>
		<?php } ?>
		
	<?php } ?>
	
	<?php
		echo $Banners->out( ["position_name"=>"ad_view_sidebar", "current_id_cat"=>$data["ad"]["category_board_id"], "categories"=>$getCategoryBoard] ); 
	?> 
     
     <div class="share_expert-box">
		<div id="share_expert-calc-height" class="share_expert-calc-height"></div>
		<div id="share_expert-calc" class="share_expert-calc">
            <div class="share_expert-calc-text">        
                <?php echo $ULang->t("Расчет доставки и растаможки автомобиля в вашу страну"); ?>
			</div>
            <div class="share_expert-calc-description">        
                *<?php echo $ULang->t("все расчёты ориентировочные предварительно проконсультируйтесь с экспертом"); ?>
			</div>
            <div class="country_price country_price-open" style="position: relative;cursor:pointer;">
                <div class="country_price-icon ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="15" viewBox="0 0 13 15" fill="none">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M6.5 8.495C7.03026 8.495 7.53882 8.28443 7.91386 7.90957C8.2889 7.53471 8.49973 7.02626 8.5 6.496C8.5 5.96557 8.28929 5.45686 7.91421 5.08179C7.53914 4.70672 7.03043 4.496 6.5 4.496C5.96957 4.496 5.46086 4.70672 5.08579 5.08179C4.71071 5.45686 4.5 5.96557 4.5 6.496C4.50027 7.02626 4.7111 7.53471 5.08614 7.90957C5.46118 8.28443 5.96974 8.495 6.5 8.495Z" stroke="black" stroke-linecap="square"/>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12.5 6.496C12.5 11.493 7.5 14.491 6.5 14.491C5.5 14.491 0.5 11.493 0.5 6.496C0.500795 4.90531 1.13332 3.38006 2.25848 2.25565C3.38364 1.13124 4.90931 0.499735 6.5 0.5C9.813 0.5 12.5 3.185 12.5 6.496Z" stroke="black" stroke-linecap="square"/>
					</svg>
				</div>
                <div id="country_price-text" class="country_price-text ">
                    <?php echo $ULang->t("Выберите страну"); ?>                 
				</div>
                <div class="country_price-arrow ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none">
                        <path d="M11.2008 4L6.00078 9.6L0.800781 4" stroke="black" stroke-width="0.8" stroke-linecap="square"/>
					</svg>
				</div>
                <div class="country_list-price">
                    <?php
						$getLang = getAll("SELECT * FROM uni_calc ORDER BY id", [1]);												
						if(count($getLang)){
							foreach ($getLang as $key => $value) {
							?>                                
							<div class="country_price_set <?php if($value["name"] === "Грузия"){echo country_gruz;}?>" style="margin: 0;">                                    
								<span><?php echo $value["name"];?></span>
								<span class="actiz_calc" style="display: none;"><?php echo $value["actiz"];?></span>                                   
								<span class="nal_customs_calc" style="display: none;"><?php echo $value["nal_customs"];?></span>                                   
								<span class="apply_calc" style="display: none;"><?php echo $value["apply"];?></span>                                   
								<span class="nal_import_calc" style="display: none;"><?php echo $value["nal_import"];?></span>                                   
								<span class="reating_ex_calc" style="display: none;"><?php echo $value["reating_ex"];?></span>                                   
								<span class="customs_dec_calc" style="display: none;"><?php echo $value["customs_dec"];?></span>                                   
								<span class="number_transitions_calc" style="display: none;"><?php echo $value["number_transitions"];?></span>                                   
								<span class="customs_posh_calc" style="display: none;"><?php echo $value["customs_posh"];?></span>
								<span class="nds_calc" style="display: none;"><?php echo $value["nds"];?></span>
								<span class="certif_secur_calc" style="display: none;"><?php echo $value["certif_secur"];?></span>
								<span class="Recycling_calc" style="display: none;"><?php echo $value["recycling"];?></span>
								<span class="reg_calc" style="display: none;"><?php echo $value["reg"];?></span>
								<span class="Service_escort_calc" style="display: none;"><?php echo $value["service_escort"];?></span>
								<span class="apply_escort_calc" style="display: none;"><?php echo $value["apply_escort"];?></span>
								<span class="delivery_almat_calc" style="display: none;"><?php echo $value["delivery_almat"];?></span>
								<span class="operac_collecting_calc" style="display: none;"><?php echo $value["operac_collecting"];?></span>
								<span class="certif_calc" style="display: none;"><?php echo $value["certif"];?></span>
								<span class="delivery_baku_calc" style="display: none;"><?php echo $value["delivery_baku"];?></span>
								<span class="delivery_erevan_calc" style="display: none;"><?php echo $value["delivery_erevan"];?></span>
								<span class="additional_expenses_calc" style="display: none;"><?php echo $value["additional_expenses"];?></span>
								<span class="delivery_bishkent_calc" style="display: none;"><?php echo $value["delivery_bishkent"];?></span>
							</div>
							<?php
							}
						}
					?>                    
				</div>
			</div>
            <div class="calc_inf">
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Акциз"); ?></div>            
                    <div class="calc_inf-sum">                        
					</div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Налог на таможенные услуги"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Оформление"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Налог на импорт"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Оценка эксперта"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Таможенная декларация"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Транзитный номер (60 дней)"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Таможенная пошлина"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("НДC"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Сертификат безопастности"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Утильсбор"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Первичная регистрация"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Услуга “Сопровождение клиента”"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Оформление экспортных документов"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Доставка до Алматы (ориентир.)"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Операционный сбор"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Сертификат"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Доставка до Баку (ориентир.)"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Доставка до Еревана (ориентир.)"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Доп. расходы"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
                <div class="calc_inf-data" style="display:none;">
                    <div class="calc_inf-text"><?php echo $ULang->t("Доставка до Бишкека (ориентир.)"); ?></div>            
                    <div class="calc_inf-sum"></div>
				</div>
			</div>
            <div class="Final_price"> 
                <div class="Final_price-text"><?php echo $ULang->t("Итоговая цена с учётом растаможки"); ?></div>
                <div class="Final_price-data"></div>
			</div>
		</div>
	
		<div class="share_expert">
			<div class="share_expert-logo">
				<img src="/media/others/logo_share-expert.png" alt="logo">
			</div>
			<div class="share_expert-text">
				<span style="white-space: nowrap;"><?php echo $ULang->t("Связаться с экспертом"); ?></span><br>
				<?php echo $ULang->t("Поможем подобрать и доставить автомобиль в вашу страну"); ?>
			</div>
			<div class="share_expert-links">
             	<?php $url_wat = ((!empty($_SERVER['HTTPS'])) ? 'https' : 'http') . '://' . $_SERVER['HTTP_HOST'] . '/' . $_SERVER['REQUEST_URI'];?>
				<a target="_blank" href="https://wa.me/995558003828?text=%D0%97%D0%B4%D1%80%D0%B0%D0%B2%D1%81%D1%82%D0%B2%D1%83%D0%B9%D1%82%D0%B5%20!%20%F0%9F%91%8B%20%D0%9C%D0%B5%D0%BD%D1%8F%20%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D0%B5%D1%81%D1%83%D0%B5%D1%82%20%D0%BA%D0%BE%D0%BD%D1%81%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%86%D0%B8%D1%8F...<?php echo urlencode($url_wat) ?>">
					<img src="/media/others/wathsapp_share-expert.svg" alt="wb">
				</a>
				<a target="_blank" href="https://t.me/autospot_expert_bot">
					<img src="/media/others/tg_share-expert.svg" alt="tg">
				</a>
			</div>
		</div>
	</div>	
</div>