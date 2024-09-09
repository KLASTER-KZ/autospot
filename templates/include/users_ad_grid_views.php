<div class="mb25 h3" > <strong><?php echo $ULang->t( "Сейчас смотрят" ); ?></strong></div>

<div class="load-page1">
	<div class="row no-gutters gutters10">
		
		<?php
			$conn = new mysqli($config["db"]["host"], $config["db"]["user"], $config["db"]["pass"], $config["db"]["database"]);
			$conn->query("SET NAMES 'utf8mb4'");
			
			// Получаем текущую дату и время
			$currentDateTime = date('Y-m-d H:i:s');
			
			// Определяем дату и время, за которое хотим получить объявления (последний час)
			$oneHourAgo = date('Y-m-d H:i:s', strtotime('-7 DAY', strtotime($currentDateTime)));
			
			$sql_select = "SELECT vp.*, uc.city_name, ua.ads_price AS ads_price_usd
			FROM (
			SELECT ads_id, MAX(visit_date) AS max_visit_date
			FROM uni_views_users
			GROUP BY ads_id
			) AS max_dates
			INNER JOIN uni_views_users AS vp ON vp.ads_id = max_dates.ads_id AND vp.visit_date = max_dates.max_visit_date 
			INNER JOIN uni_city uc ON vp.ads_geo = uc.city_id
			INNER JOIN uni_ads ua ON vp.ads_id = ua.ads_id
			WHERE ua.ads_status = 1
			ORDER BY vp.visit_date DESC
			LIMIT 6;
			";
			
			$result_select = $conn->query($sql_select);
			
			if ($result_select->num_rows > 0) {
				while ($row = $result_select->fetch_assoc()) {
					$ads_id = $row["ads_id"];
					$ads_img = $row["ads_img"];
					$ads_title = $row["ads_title"];
					$ads_price_usd = $row["ads_price"];
					$ads_geo = $row["ads_geo"];
					$city_name = $row["city_name"];
					$ads_url = $row["ads_url"];
					$ads_count = $row["ads_count"];
					$visit_date = $row["visit_date"];
					
					// Query to retrieve ads_price from uni_ads table based on ads_id
					$sql_price = "SELECT ads_price FROM uni_ads WHERE ads_id = $ads_id";
					$result_price = $conn->query($sql_price);
					
					if ($result_price->num_rows > 0) {
						$row_price = $result_price->fetch_assoc();
						$ads_price = $row_price["ads_price"];
						} else {
						$ads_price = "N/A"; // Default value if price is not found
					}
				?>
				<div class="col-lg-2 col-md-3 col-sm-3 col-6">
					
					<a href="<?php echo $ads_url; ?>" title="<?php echo $ads_title; ?>">
						<div class='item-grid' title="<?php echo $ads_title; ?>">
							<div class="item-grid-img">
								<!--  users_ad_grid_views.php row 60 -->  
								<div class="item-labels"></div>
								<!-- 18-08-2023 Correction 44 see at log of git https://github.com/petrmileshko/autospot.ge/commits/main 
									Postpone loading images
								-->
								<img src="<?php echo $ads_img; ?>" class="image-autofocus ad-gallery-hover-slider-image lazyload" data-src="<?php echo $ads_title; ?>" data-key="0" alt="<?php echo $ads_title; ?>" loading="lazy" decoding="async">
								<span style="top: auto;" class="item-grid-count-photo"><i class="las la-camera"></i><?php echo $ads_count; ?></span>
								
							</div>
							<div class="item-grid-info">
								<div class="item-grid-price-now">
									<?php
										$language = getLang();
										if (strpos($ads_price_usd, 'Цена договорная') !== false) {
											if ($language === getLang()) {
												echo $ULang->t("Цена договорная");
												} else {
												echo "Price not specified";
											}
											} else {
										?>
										<div class="item-grid-price">
											<!-- Блок с ценой в USD -->
											<div id="usdPriceBlock_<?php echo $ads_id ?>6">
												<?php echo $ads_price_usd; ?>
											</div>
											
											<!-- Блок с ценой в LARI (скрыт по умолчанию) -->
											<div id="lariPriceBlock_<?php echo $ads_id ?>6" style="display: none;">
												<?php echo ($ads_price == 0) ? "".$ULang->t( "Договорная" )."" : number_format($ads_price, 0, '', ',') . " ₾"; ?>
												
												
											</div>
										</div>
										
										<script>
											$(document).ready(function () {
												// Получить значение выбранной кнопки из Local Storage
												var selectedButton = localStorage.getItem('selectedButton');
												
												// При загрузке страницы восстановить состояние кнопок
												if (selectedButton === 'lari') {
													$("#usdPriceBlock_<?php echo $ads_id ?>6").hide();
													$("#lariPriceBlock_<?php echo $ads_id ?>6").show();
													} else {
													$("#usdPriceBlock_<?php echo $ads_id ?>6").show();
													$("#lariPriceBlock_<?php echo $ads_id ?>6").hide();
												}
												
												// При нажатии на кнопку "USD"
												$("#btnUSD").on("click", function () {
													// Показать блок с ценой в USD
													$("#usdPriceBlock_<?php echo $ads_id ?>6").show();
													// Скрыть блок с ценой в LARI
													$("#lariPriceBlock_<?php echo $ads_id ?>6").hide();
													// Сохранить выбранную кнопку в Local Storage
													localStorage.setItem('selectedButton', 'usd');
												});
												
												// При нажатии на кнопку "LARI"
												$("#btnLARI").on("click", function () {
													// Скрыть блок с ценой в USD
													$("#usdPriceBlock_<?php echo $ads_id ?>6").hide();
													// Показать блок с ценой в LARI
													$("#lariPriceBlock_<?php echo $ads_id ?>6").show();
													// Сохранить выбранную кнопку в Local Storage
													localStorage.setItem('selectedButton', 'lari');
												});
												// При нажатии на кнопку "USD"
												$("#btnUSD2").on("click", function () {
													// Показать блок с ценой в USD
													$("#usdPriceBlock_<?php echo $ads_id ?>6").show();
													// Скрыть блок с ценой в LARI
													$("#lariPriceBlock_<?php echo $ads_id ?>6").hide();
													// Сохранить выбранную кнопку в Local Storage
													localStorage.setItem('selectedButton', 'usd');
												});
												
												// При нажатии на кнопку "LARI"
												$("#btnLARI2").on("click", function () {
													// Скрыть блок с ценой в USD
													$("#usdPriceBlock_<?php echo $ads_id ?>6").hide();
													// Показать блок с ценой в LARI
													$("#lariPriceBlock_<?php echo $ads_id ?>6").show();
													// Сохранить выбранную кнопку в Local Storage
													localStorage.setItem('selectedButton', 'lari');
												});
											});
										</script>
										
										<?php
										}
									?>
								</div>
								<!-- 16-08-2023 Correction 20 Replaced <a></a> inside other link by span -->
								<span><a href="<?php echo $ads_url; ?>" title="<?php echo $ads_title; ?>">
									<?php
										$datas = custom_substr($ads_title, 35, "...");
										$parts = explode(" ", $datas);
										
										for ($i = 0; $i <= min(count($parts), 100); $i++) {
											echo '<span class="tag' . $i . '"> '.$ULang->t($parts[$i], ["table" => "uni_ads_filters", "field" => "ads_filters_items_value"]).' </span>';
										}
									?></a></span>
									<span class="item-grid-city"><?php echo $ULang->t($value["city_name"], ["table" => "geo", "field" => "geo_name"]); ?></span>
									<?php 
										
										$filters = [
										'312' => 'query_1',
										'310' => 'query_2',
										'314' => 'query_3',
										'89' => 'query_4',
										];
										
										$conn = new mysqli($config["db"]["host"], $config["db"]["user"], $config["db"]["pass"], $config["db"]["database"]);
										
										foreach ($filters as $filterId => $varName) {
											$query = "SELECT ads_filters_variants_product_id, ads_filters_variants_val 
											FROM uni_ads_filters_variants 
											WHERE ads_filters_variants_product_id = ? 
											AND ads_filters_variants_id_filter = ?";
											
											$stmt = $conn->prepare($query);
											$stmt->bind_param("ii", $ads_id, $filterId); // "ii" указывает на два целых числа
											
											if ($stmt->execute()) {
												$result = $stmt->get_result();
												$$varName = $result->fetch_all(MYSQLI_ASSOC);
												} else {
												echo "Ошибка выполнения запроса: " . $stmt->error;
											}
										}
										
									?>		
									
									<div class="property-list">
										<div>
											<?php foreach ($query_2 AS $value2): ?>
											<svg fill="#242424" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve" width="18px" height="18px"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <g> <path d="M437.02,74.98C388.667,26.628,324.38,0,256,0S123.333,26.628,74.98,74.98C26.628,123.333,0,187.62,0,256 s26.628,132.667,74.98,181.02C123.333,485.372,187.62,512,256,512s132.667-26.628,181.02-74.98 C485.372,388.667,512,324.38,512,256S485.372,123.333,437.02,74.98z M256,478.609c-122.746,0-222.609-99.862-222.609-222.609 S133.254,33.391,256,33.391S478.609,133.254,478.609,256S378.746,478.609,256,478.609z"></path> </g> </g> <g> <g> <rect x="239.304" y="66.445" width="33.391" height="54.973"></rect> </g> </g> <g> <g> <rect x="144.041" y="97.397" transform="matrix(0.809 -0.5878 0.5878 0.809 -42.7066 118.3336)" width="33.391" height="54.973"></rect> </g> </g> <g> <g> <rect x="85.16" y="178.422" transform="matrix(0.309 -0.9511 0.9511 0.309 -125.4502 239.1576)" width="33.392" height="54.975"></rect> </g> </g> <g> <g> <rect x="74.387" y="289.382" transform="matrix(0.9511 -0.309 0.309 0.9511 -89.5896 46.456)" width="54.975" height="33.392"></rect> </g> </g> <g> <g> <rect x="393.426" y="278.583" transform="matrix(0.309 -0.9511 0.9511 0.309 -7.6944 601.5519)" width="33.393" height="54.975"></rect> </g> </g> <g> <g> <rect x="382.634" y="189.215" transform="matrix(0.9511 -0.309 0.309 0.9511 -43.5552 136.799)" width="54.975" height="33.393"></rect> </g> </g> <g> <g> <rect x="323.78" y="108.202" transform="matrix(0.5878 -0.809 0.809 0.5878 43.7479 335.6581)" width="54.973" height="33.391"></rect> </g> </g> <g> <g> <path d="M169.275,335.566v102.047h173.449V335.566H169.275z M309.333,404.222H202.666v-35.265h0h106.666V404.222z"></path> </g> </g> <g> <g> <path d="M272.696,233.859v-82.237h-33.391v82.237c-15.303,6.516-26.06,21.704-26.06,39.359c0,23.575,19.18,42.755,42.755,42.755 s42.755-19.18,42.755-42.755C298.755,255.564,287.999,240.376,272.696,233.859z M256,282.583c-5.163,0-9.364-4.201-9.364-9.364 c0-5.163,4.201-9.364,9.364-9.364c5.163,0,9.364,4.201,9.364,9.364C265.364,278.382,261.163,282.583,256,282.583z"></path> </g> </g> </g></svg>
											
											<?php
												$value2 = $value2['ads_filters_variants_val'];
												$formatted_value = ($value2 >= 1000) ? number_format($value2 / 1000, 0, '', ' ') . ' ' . $ULang->t("тыс. км") : number_format($value2, 0, '', ' ') . ' ' . $ULang->t("км");
												echo $formatted_value;
											?>
											<?php endforeach; ?>
											
											<?php foreach ($query_4 as $value1): ?>
											<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <circle cx="12" cy="12" r="10" stroke="#474747" stroke-width="1.5"></circle> <circle cx="12" cy="12" r="6" stroke="#474747" stroke-width="1.5"></circle> <circle cx="12" cy="12" r="2" stroke="#474747" stroke-width="1.5"></circle> <path d="M6 12L10 12" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M14 12L18 12" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M9 17.1963L11 13.7322" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M13 10.2681L15 6.80396" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M15 17.1963L13 13.7322" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M11 10.2681L9 6.80396" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> </g></svg>
											<?php
												$get2 = getAll("SELECT ads_filters_items_value FROM uni_ads_filters_items WHERE ads_filters_items_id = " . $value1['ads_filters_variants_val'] . ";");
												foreach ($get2 as $value2) {
													echo $ULang->t($value2['ads_filters_items_value']);
												}
											?>
											<?php endforeach; ?> 
										</div>
										<div>
											<?php foreach ($query_3 AS $value3): ?>
											<svg fill="#575757" height="20px" width="20px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 511.999 511.999" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <g> <path d="M494.32,196.801l-4.858-8.131h-85.516v39.564h-8.557v-57.371h-44.32l-28.138-24.95h-46.53v-22.695h14.966V89.827H172.742 v33.391h14.966v22.695h-48.443l-28.138,24.95H55.791v16.696v66.236h-22.4v-42.616H0v118.625h33.391v-42.617h22.4v66.236v16.696 h83.474l58.709,52.054h197.414v-58.444h8.557v39.565h85.516l4.858-8.132c1.81-3.027,17.68-31.537,17.68-99.181 S496.13,199.829,494.32,196.801z M221.101,123.22h21.909v22.695h-21.909V123.22z M468.927,369.902h-31.59v-39.565h-75.34v58.444 H210.646l-58.709-52.054H89.183V204.255h34.617l28.138-24.95h158.32l28.138,24.95h23.601v57.371h75.34v-39.564h31.59 c3.873,11.386,9.681,34.956,9.681,73.921C478.609,334.947,472.801,358.516,468.927,369.902z"></path> </g> </g> </g></svg>
											<?php
												$originalValue = $value3['ads_filters_variants_val'];
												$formattedValue = number_format($originalValue, 1);
												echo $formattedValue;
											?>
											<?php endforeach; ?>
											
											<?php foreach ($query_1 as $value4): ?>
											<?php
												$get2 = getAll("SELECT ads_filters_items_value FROM uni_ads_filters_items WHERE ads_filters_items_id = " . $value4['ads_filters_variants_val'] . ";");
												foreach ($get2 as $value4) {
													echo $ULang->t($value4['ads_filters_items_value']);
												}
											?>
											<?php endforeach; ?> 
											
										</div>
									</div>
									
							</div>
							
						</div>
					</a>	<!-- 16-08-2023 Correction 21 closing tag </a> was after parent container tag </div> -->
				</div>
				<?php
				}
			}
		?>
		
	</div>
	<div class="text-right mt20">
		<a style="color:#000; font-size:15px;" href="georgia?search="><?php echo $ULang->t( "Больше объявлений" ); ?> <i class="las la-arrow-right"></i></a> 
	</div>
	<style>.slick-track{float:left;}.board-view-price{font-size:15px;}</style>
	<!-- 16-08-2023
		Correction 21  Element style not allowed as child of element div
		transferring to index.tpl in <head></head> section
		
	-->
