<!doctype html>
<html lang="<?php echo getLang(); ?>">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<meta name="description" content="<?php echo $data["meta_desc"]; ?>"> 

	<title>
		
		<?php echo $data["meta_title"]; ?>
	</title>

	<link rel="canonical" href="<?php echo _link( explode(" ?", $_SERVER['REQUEST_URI'])[0] ); ?>"/>

	<?php include $config["template_path"] . "/head.tpl"; ?>
	<style>
		body {
			background: #f7f8fa;
		}

		.view__all-ads {
			width: 100%;
			display: block;
			text-align: center;
			border-radius: 20px;
			background: #F0EDED;
			padding: 17px;
			font-size: 16px;
			font-weight: 400;
			color: #000;
		}

		.view__all-ads:hover {
			color: #000;
		}
	</style>

</head>

<body data-mark_filter="<?php echo $mark_filter;?>" data-model_filter="<?php echo $model_filter;?>" data-prefix="<?php echo $config["urlPrefix"]; ?>" data-template="
	<?php echo $config["template_folder"]; ?>" data-type-loading="
	<?php echo $settings["type_content_loading"]; ?>">
	<?php include $config["template_path"] . "/header.tpl"; ?>
	
	<?php if(!$model){ ?>
		<div class="container">
			<?php echo $Banners->out( ["position_name"=>"catalog_base_top"] ); ?>
		
		
				<?php if($data['filter_found']) {?>
					
					<div class="filter_base-mob">
						<i class="las la-sliders-h" style="font-size: 17px;"></i>
						<span><?php echo $ULang->t( "Параметры" ); ?></span>
					</div>
		
					<form class="filters_base">
						<div class="filter_base-mob-close">
							<svg xmlns="http://www.w3.org/2000/svg" width="25px" height="25px" viewBox="-0.5 0 25 25" fill="none">
								<path d="M3 21.32L21 3.32001" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
								<path d="M3 3.32001L21 21.32" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
								</svg>
						</div>
						<div class="filters_base-box">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Марка"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list mark">
									<?php foreach($filters_data['mark'] as $key => $mark){?>
									<div class="custom-control custom-radio" onclick="">
										<input data-model="<?php echo $mark['id']?>" type="radio" class="custom-control-input" name="filter[mark]" <?php
											if($_GET["filter"]["mark"]==$mark['name']){ echo 'checked' ; } ?> id="mark<?php echo $key?>"
										value="<?php echo $mark['name']; ?>" >
										<label class="custom-control-label" for="mark<?php echo $key?>">
											<?php echo $ULang->t($mark['name']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-box">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Кузов"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['body_type'] as $key => $body_type){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[body-type]" <?php
											if($_GET["filter"]["body-type"]==$body_type['body-type']){ echo 'checked' ; } ?> id="body_type<?php echo $key?>"
										value="<?php echo $body_type['body-type']; ?>" >
										<label class="custom-control-label" for="body_type<?php echo $key?>">
											<?php echo $ULang->t($body_type['body-type']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
					
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Коробка"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['transmission'] as $key => $transmission){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[transmission]" <?php
											if($_GET["filter"]["transmission"]==$transmission['transmission']){ echo 'checked="true"' ; } ?> id="transmission<?php echo $key?>"
										value="<?php echo $transmission['transmission']; ?>" >
										<label class="custom-control-label" for="transmission<?php echo $key?>">
											<?php echo $ULang->t($transmission['transmission']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-box">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Двигатель"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['engine_type'] as $key => $engine_type){?>	
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[engine_type]" <?php if($_GET["filter"]["engine_type"]==$engine_type['engine-type']){ echo 'checked'; } ?> id="engine_type<?php echo $key?>"
										value="<?php echo $engine_type['engine-type']; ?>">
										<label class="custom-control-label" for="engine_type<?php echo $key?>">
											<?php echo $ULang->t($engine_type['engine-type']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
							
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Привод"); ?></span> 
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['drive'] as $key => $drive){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[drive]" <?php
											if($_GET["filter"]["drive"]==$drive['drive']){ echo 'checked="true"' ; } ?> id="drive<?php echo $key?>"
										value="<?php echo $drive['drive']; ?>" >
										<label class="custom-control-label" for="drive<?php echo $key?>">
											<?php echo $ULang->t($drive['drive']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-block">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Год от"); ?> </span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php for($i = date("Y"); $i >= $filters_data['year_min']; $i--){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[year_from]" <?php
											if($_GET["filter"]["year_from"]==$i){ echo 'checked' ; } ?> id="year_from<?php echo $i?>"
										value="<?php echo $i?>" >
										<label class="custom-control-label" for="year_from<?php echo $i?>">
											<?php echo $i ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
					
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("до"); ?> </span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php for($i = date("Y"); $i >= $filters_data['year_min']; $i--){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[year_to]" <?php
											if($_GET["filter"]["year_to"]==$i){ echo 'checked="true"' ; } ?> id="year_to<?php echo $i?>"
										value="<?php echo $i?>" >
										<label class="custom-control-label" for="year_to<?php echo $i?>">
											<?php echo $i ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-block">
							<label class="filters_base-inpt">
								<input type="text" name="filter[horse-power-from]" id="" placeholder="<?php echo $ULang->t("Мощность от, л.с."); ?>" value="<?php if($_GET['filter']['horse-power-from']){ echo $_GET['filter']['horse-power-from'];}?>">
							</label>
					
							<label class="filters_base-inpt">
								<input type="text" name="filter[horse-power-to]" id="" placeholder="<?php echo $ULang->t("до"); ?> "
								value="<?php if($_GET['filter']['horse-power-to']){ echo $_GET['filter']['horse-power-to'];}?>">
							</label>
						</div>
						<button type="submit" id="filter_base"> <?php echo $ULang->t("Применить"); ?></button>
					</form>


		
					<nav aria-label="breadcrumb">
		
						<ol class="breadcrumb" itemscope="" itemtype="http://schema.org/BreadcrumbList">
			
							<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
								itemtype="http://schema.org/ListItem">
								<a itemprop="item" href="<?php echo $config["urlPath"]; ?>">
									<span itemprop="name">
										<?php echo $ULang->t("Главная"); ?>
									</span></a>
								<meta itemprop="position" content="1">
							</li>
							<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
								itemtype="http://schema.org/ListItem">
								<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' ; ?>">
									<span itemprop="name">
										<?php echo $ULang->t("Каталог"); ?>
									</span></a>
								<meta itemprop="position" content="2">
							</li>
			
						</ol>
			
					</nav>

					<div class="row">
						<div class="col-lg-10">
		
					<div class="catalog-base-results">
						<div class="preload"></div>
						<div class="row no-gutters gutters10">
							<?php 
						foreach($found[0] as $car){
							include $config["template_path"] . "/include/base_auto_ad_filter.php";
							 
						} 
						?>
		
						
						</div>
					</div>
					<?php $flag_page = 1;?>
					<div class="page-base__box">						
						<?php if($found['pages'] > 1){
						 for($page=1;$page <= $found['pages']; $page++){ ?>				
							<?php if(($found['pages'] == $page) || ($page <= 3 && !$_GET['page']) || (($_GET['page'] - 2) <= $page && ($_GET['page'] + 2) >= $page)){ ?>
							<button id="page_nav" 
							class="page-base__button <?php if(($page == $_GET['page'] && $_GET['page'])) { echo 'active'; } else if($page == 1 && !$_GET['page']) {echo 'active'; }?>"
							data-page="<?php echo $page;?>">
								<?php echo $page;?>
							</button>
							<?php $flag_page = 1;?>
							<?php } else if($flag_page == 1){ ?>
								<?php $flag_page = 0;?>
								<div class="page-base__button">
									...
								</div>
						<?php } 
						}
					}?>
					</div>
		
				
				<?php }?>
				<?php if($data['newcatalog']){?>

					
		
					<div class="filter_base-mob">
						<i class="las la-sliders-h" style="font-size: 17px;"></i>
						<span><?php echo $ULang->t( "Параметры" ); ?></span>
					</div>
		
					<form class="filters_base">
						<div class="filter_base-mob-close">
							<svg xmlns="http://www.w3.org/2000/svg" width="25px" height="25px" viewBox="-0.5 0 25 25" fill="none">
								<path d="M3 21.32L21 3.32001" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
								<path d="M3 3.32001L21 21.32" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
								</svg>
						</div>
						<div class="filters_base-box">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Марка"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list mark">
									<?php foreach($filters_data['mark'] as $key => $mark){?>
									<div class="custom-control custom-radio" onclick="">
										<input data-model="<?php echo $mark['id']?>" type="radio" class="custom-control-input" name="filter[mark]" <?php
											if($_GET["filter"]["mark"]==$mark['name']){ echo 'checked' ; } ?> id="mark<?php echo $key?>"
										value="<?php echo $mark['name']; ?>" >
										<label class="custom-control-label" for="mark<?php echo $key?>">
											<?php echo $ULang->t($mark['name']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-box">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Кузов"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['body_type'] as $key => $body_type){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[body-type]" <?php
											if($_GET["filter"]["body-type"]==$body_type['body-type']){ echo 'checked' ; } ?> id="body_type<?php echo $key?>"
										value="<?php echo $body_type['body-type']; ?>" >
										<label class="custom-control-label" for="body_type<?php echo $key?>">
											<?php echo $ULang->t($body_type['body-type']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
					
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Коробка"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['transmission'] as $key => $transmission){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[transmission]" <?php
											if($_GET["filter"]["transmission"]==$transmission['transmission']){ echo 'checked="true"' ; } ?> id="transmission<?php echo $key?>"
										value="<?php echo $transmission['transmission']; ?>" >
										<label class="custom-control-label" for="transmission<?php echo $key?>">
											<?php echo $ULang->t($transmission['transmission']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-box">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Двигатель"); ?></span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['engine_type'] as $key => $engine_type){?>	
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[engine_type]" <?php if($_GET["filter"]["engine_type"]==$engine_type['engine-type']){ echo 'checked'; } ?> id="engine_type<?php echo $key?>"
										value="<?php echo $engine_type['engine-type']; ?>">
										<label class="custom-control-label" for="engine_type<?php echo $key?>">
											<?php echo $ULang->t($engine_type['engine-type']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
							
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Привод"); ?></span> 
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php foreach($filters_data['drive'] as $key => $drive){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[drive]" <?php
											if($_GET["filter"]["drive"]==$drive['drive']){ echo 'checked="true"' ; } ?> id="drive<?php echo $key?>"
										value="<?php echo $drive['drive']; ?>" >
										<label class="custom-control-label" for="drive<?php echo $key?>">
											<?php echo $ULang->t($drive['drive']); ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-block">
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("Год от"); ?> </span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php for($i = date("Y"); $i >= $filters_data['year_min']; $i--){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[year_from]" <?php
											if($_GET["filter"]["year_from"]==$i){ echo 'checked' ; } ?> id="year_from<?php echo $i?>"
										value="<?php echo $i?>" >
										<label class="custom-control-label" for="year_from<?php echo $i?>">
											<?php echo $i ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
					
							<div class="uni-select filter_base" data-status="0">
								<div class="uni-select-name">								
									<span><?php echo $ULang->t("до"); ?> </span>
									<i class="la la-angle-down"></i>
								</div>
								<div class="uni-select-list">
									<?php for($i = date("Y"); $i >= $filters_data['year_min']; $i--){?>
									<div class="custom-control custom-radio" onclick="">
										<input type="radio" class="custom-control-input" name="filter[year_to]" <?php
											if($_GET["filter"]["year_to"]==$i){ echo 'checked="true"' ; } ?> id="year_to<?php echo $i?>"
										value="<?php echo $i?>" >
										<label class="custom-control-label" for="year_to<?php echo $i?>">
											<?php echo $i ?>
										</label>
									</div>
									<?php }?>
								</div>
							</div>
						</div>
						<div class="filters_base-block">
							<label class="filters_base-inpt">
								<input type="text" name="filter[horse-power-from]" id="" placeholder="<?php echo $ULang->t("Мощность от, л.с."); ?> " value="<?php if($_GET['filter']['horse-power-from']){ echo $_GET['filter']['horse-power-from'];}?>">
							</label>
					
							<label class="filters_base-inpt">
								<input type="text" name="filter[horse-power-to]" id="" placeholder="<?php echo $ULang->t("до"); ?> "
								value="<?php if($_GET['filter']['horse-power-to']){ echo $_GET['filter']['horse-power-to'];}?>">
							</label>
						</div>
						<button type="submit" id="filter_base"><?php echo $ULang->t("Применить"); ?></button>
					</form>

		
					
				<nav aria-label="breadcrumb">
		
					<ol class="breadcrumb" itemscope="" itemtype="http://schema.org/BreadcrumbList">
		
						<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
							itemtype="http://schema.org/ListItem">
							<a itemprop="item" href="<?php echo $config["urlPath"]; ?>">
								<span itemprop="name">
									<?php echo $ULang->t("Главная"); ?>
								</span></a>
							<meta itemprop="position" content="1">
						</li>
						<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
							itemtype="http://schema.org/ListItem">
							<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' ; ?>">
								<span itemprop="name">
									<?php echo $ULang->t("Каталог"); ?>
								</span></a>
							<meta itemprop="position" content="2">
						</li>
		
					</ol>
		
				</nav>

				<div class="row">
					<div class="col-lg-10">

				<div class="h3 mb20">
					<strong>
						<?php echo $ULang->t("Выбор автомобиля по марке"); ?>
					</strong>
					<a class="content_toggle" style="text-decoration: none;" href="#">   
						<?php echo $ULang->t("Все марки"); ?> <i class="la la-angle-down"></i>
					</a>
				</div>
				<div class="content_block hide">
					<?php echo $Ads->generateAdsFilterItems('base'); ?>
				</div>
		

				

				<div class="h3 mb20" style="margin-top: 20px;">
					<strong>
						<?php echo $ULang->t( "Новинки каталога" ); ?>
					</strong>
				</div>
				<div class="row no-gutters gutters10" id="newcatalog">
					<?php	foreach($newCatalog as $catalog){ ?>
					<div class="col-md-3 newcatalog_cart">
						<a href="/catalog/<?php echo  $catalog['mark']['name'] . '/' . $catalog['id'];?>/" class="item-grid">
							<div class="item-grid-img-base">
								<img loading="lazy" data-src="<?php echo Exists($config[" media"]["car_photos"],
									$catalog['configuration'][0][0]['id'].".jpg", $config["media"]["no_image"]);?>" src="
								<?php echo Exists($config["media"]["car_photos"], $catalog['configuration'][0][0]['id'].".jpg", $config["media"]["no_image"]);?>"
								alt="Car_photo">
								<div class="item-grid-inf-base">
									<strong>
										<?php echo  $catalog['mark']['name'] . ' ' . $catalog['name'];?>
									</strong>
									<span></span>
								</div>
							</div>
						</a>
					</div>
					<?php }?>
				</div>
				
				<?php } else if(!$data['filter_found']){?>
				<nav aria-label="breadcrumb">
		
					<ol class="breadcrumb" itemscope="" itemtype="http://schema.org/BreadcrumbList">
		
						<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
							itemtype="http://schema.org/ListItem">
							<a itemprop="item" href="<?php echo $config["urlPath"]; ?>">
								<span itemprop="name">
									<?php echo $ULang->t("Главная"); ?>
								</span></a>
							<meta itemprop="position" content="1">
						</li>
						<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
							itemtype="http://schema.org/ListItem">
							<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' ; ?>">
								<span itemprop="name">
									<?php echo $ULang->t("Каталог"); ?>
								</span></a>
							<meta itemprop="position" content="2">
						</li>
						<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
							itemtype="http://schema.org/ListItem">
							<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
								$found[0][0]['mark']['name']; ?>">
								<span itemprop="name">
									<?php echo $found[0][0]['mark']['name']; ?>
								</span></a>
							<meta itemprop="position" content="3">
						</li>
		
					</ol>
		
				</nav>
				<div class="row">
					<div class="col-lg-10">
				<div class="catalog-base-results">
					<div class="preload"></div>
					<h2 class="title-and-link h4" style="font-size:30px; margin-bottom: 30px; font-weight: 900;">Модели <?php echo $found[0][0]['mark']['name'];?></h2>
					<div class="row no-gutters gutters10" style="margin-bottom: 20px;">
						<?php 
						
					foreach($found[0] as $car){
						include $config["template_path"] . "/include/base_auto_ad_grid.php";
						 
					} 
					?>
					</div>

					
		
					<?php $flag_page = 1;?>
					<div class="page-base__box">						
						<?php if($found['pages'] > 1){
						 for($page=1;$page <= $found['pages']; $page++){ ?>				
							<?php if(($found['pages'] == $page) || ($page <= 3 && !$_GET['page']) || (($_GET['page'] - 2) <= $page && ($_GET['page'] + 2) >= $page)){ ?>
							<button id="page_nav" 
							class="page-base__button <?php if(($page == $_GET['page'] && $_GET['page'])) { echo 'active'; } else if($page == 1 && !$_GET['page']) {echo 'active'; }?>"
							data-page="<?php echo $page;?>">
								<?php echo $page;?>
							</button>
							<?php $flag_page = 1;?>
							<?php } else if($flag_page == 1){ ?>
								<?php $flag_page = 0;?>
								<div class="page-base__button">
									...
								</div>
						<?php } 
						}
					}?>
					</div>
				</div>
				<?php }?>
			</div>
			<div class="col-lg-2">
				<?php echo $Banners->out( ["position_name"=>"catalog_base_sidebar"] ); ?>
			</div>
		</div>
		<?php echo $Banners->out( ["position_name"=>"catalog_base_bottom"] ); ?>
	</div>
	<?php } else { ?>
	<div class="container" style="padding-bottom: 60px;">

		<?php
			if($generation) { ?>
		<nav aria-label="breadcrumb">

			<ol class="breadcrumb" itemscope="" itemtype="http://schema.org/BreadcrumbList">

				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"]; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Главная"); ?>
						</span></a>
					<meta itemprop="position" content="1">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' ; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Каталог"); ?>
						</span></a>
					<meta itemprop="position" content="2">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model[0]['mark']['name'] ; ?>">
						<span itemprop="name">
							<?php echo $data_model[0]['mark']['name']; ?>
						</span></a>
					<meta itemprop="position" content="3">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model[0]['mark']['name'] . '/' . $data_model[0]['id']; ?>">
						<span itemprop="name">
							<?php echo $data_model[0]['name']; ?>
						</span></a>
					<meta itemprop="position" content="4">
				</li>

			</ol>

		</nav>
		<?php foreach($data_model as $cars){ 
					include $config["template_path"] . "/include/base_auto_ad_generations.php"; 
				}

?>				


<div class="catalog__buy mt-4">
	<h2 class="title-and-link h4" style="font-size:30px; margin-bottom: 30px;font-weight: 900;"><?php echo $ULang->t("Продажа"); ?> <?php echo $cars['mark']['name'];?> <?php if($model_filter) { echo $cars['name']; } ?></h2>
</div>
<a class="view__all-ads" href="/georgia/avtomobili?filter[302][]=<?php echo $model_filter?>&filter[90][]=<?php echo $mark_filter?>" target="_blank"><?php echo $ULang->t("Показать все объявления"); ?></a>


<?php

				echo $Banners->out( ["position_name"=>"catalog_base_bottom"] );
			} else if(!$complectation) {
				?>

		<nav aria-label="breadcrumb">

			<ol class="breadcrumb" itemscope="" itemtype="http://schema.org/BreadcrumbList">

				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"]; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Главная"); ?>
						</span></a>
					<meta itemprop="position" content="1">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' ; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Каталог"); ?>
						</span></a>
					<meta itemprop="position" content="2">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] ; ?>">
						<span itemprop="name">
							<?php echo $data_model['mark']['name']; ?>
						</span></a>
					<meta itemprop="position" content="3">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] . '/' . $data_model['id'] . '/' ; ?>">
						<span itemprop="name">
							<?php echo $data_model['name']; ?>
						</span></a>
					<meta itemprop="position" content="4">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] . '/' . $data_model['id'] . '/' .
						$data_model['generation'][0]['year-start']; ?>">
						<span itemprop="name">
							<?php echo $data_model['generation'][0]['year-start']; ?>
						</span></a>
					<meta itemprop="position" content="5">
				</li>

			</ol>

		</nav>






		<div class="h3 mb20">
			<strong class="title-and-link h4" style="font-size:30px; margin-bottom: 30px;">
				<?php echo $data_model['mark']['name'].' '.$data_model['name'];?>,
				<?php echo $data_model['configuration'][0][0]['body-type'];?>,
				<?php echo $data_model['generation'][0]['name']? $data_model['generation'][0]['name'] : '';?> (
				<?php echo $data_model['generation'][0]['year-start'].'-' ;?>
				<?php if($data_model['generation'][0]['year-stop']) echo $data_model['generation'][0]['year-stop']; else echo '...';?>)
				- <br> <?php echo $ULang->t("Технические характеристики и комплектации"); ?>
			</strong>
		</div>

		<h1 class="title-and-link h4"><strong>Комплектации
				<?php echo $data_model['mark']['name'].' '.$data_model['name'];?>
			</strong></h1>

		<div class="complectation_img-box">
			<img src="<?php echo Exists($config["media"]["car_photos"],$data_model['configuration'][0][0]['id'].".jpg", $config["media"]["no_image"]);?>"
			class="complectation_img" alt="Car_photo">
		</div>

		<div class="complect_head">
			<div class="complect_head-td"></div>
		</div>
		<div class="complect_table">
			<div class="complect_table-head">
				<div class="complect_table-head-td"><?php echo $ULang->t("Двигатель"); ?></div>
				<div class="complect_table-head-td"><?php echo $ULang->t("Привод"); ?></div>
				<div class="complect_table-head-td"><?php echo $ULang->t("Коробка"); ?></div>
			</div>
		<?php foreach($data_model['modification'] as $key => $modification){?>

		
			
			<div class="complect_table-body">
				<div class="complect_table-body-block" id="complectation" data-complect="<?php echo $key;?>">
					<div class="complect_table-body-td"> 
						<?php if($data_model['specifications'][$key]['volume-litres']){ echo $data_model['specifications'][$key]['volume-litres'].' л., ';} ?>
						<?php if($data_model['specifications'][$key]['horse-power']){ echo $data_model['specifications'][$key]['horse-power'].' л.с., ';} ?>
						<?php if($data_model['specifications'][$key]['engine-type']){ echo $data_model['specifications'][$key]['engine-type']  ;} ?>
					</div> 
					<div class="complect_table-body-td">
						<?php echo $data_model['specifications'][$key]['drive'] ;?>
					</div>
					<div class="complect_table-body-td">
						<?php echo $data_model['specifications'][$key]['transmission'] ;?>
					</div>
				</div>
				
			</div>
		



		<?php }?>
	</div>

	<?php echo $Banners->out( ["position_name"=>"catalog_base_bottom"] ); ?>

		<?php } else {?>

		<nav aria-label="breadcrumb">

			<ol class="breadcrumb" itemscope="" itemtype="http://schema.org/BreadcrumbList">

				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"]; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Главная"); ?>
						</span></a>
					<meta itemprop="position" content="1">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' ; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Каталог"); ?>
						</span></a>
					<meta itemprop="position" content="2">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] ; ?>">
						<span itemprop="name">
							<?php echo $data_model['mark']['name']; ?>
						</span></a>
					<meta itemprop="position" content="3">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] . '/' . $data_model['id'] . '/' . $data_model['id']; ?>">
						<span itemprop="name">
							<?php echo $data_model['name']; ?>
						</span></a>
					<meta itemprop="position" content="4">
				</li>
				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] . '/' . $data_model['id'] . '/' .
						$data_model['generation'][0]['year-start']; ?>">
						<span itemprop="name">
							<?php echo $data_model['generation'][0]['year-start']; ?>
						</span></a>
					<meta itemprop="position" content="5">
				</li>

				<li class="breadcrumb-item" itemprop="itemListElement" itemscope=""
					itemtype="http://schema.org/ListItem">
					<a itemprop="item" href="<?php echo $config["urlPath"] . '/catalog' . '/' .
						$data_model['mark']['name'] . '/' . $data_model['id'] . '/' .
						$data_model['generation'][0]['year-start'] . '/' . $key_complect; ?>">
						<span itemprop="name">
							<?php echo $ULang->t("Комплектация") . '-' . ($key_complect + 1); ?>
						</span></a>
					<meta itemprop="position" content="6">
				</li>

			</ol>

		</nav>

	<div class="row">
		<div class="col-lg-10">

		<div class="complectation_img-box">
			<img src="<?php echo Exists($config["media"]["car_photos"],$data_model['configuration'][0][0]['id'].".jpg", $config["media"]["no_image"]);?>"
			class="complectation_img" alt="Car_photo">
		</div> 

		<div class="complect_box-top">
			<svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="386" height="205">
					
				<g>
					<pattern height="1" width="1" patternContentUnits="objectBoundingBox" id="pattern0_782_249">
					<use id="svg_1" transform="scale(0.0031250000465661287,0.00523559981957078) " xlink:href="#image0_782_249"/>
					</pattern>
					<image xlink:href="data:image/png;svgedit_url=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAAUAAAAC%2FCAYAAACPIwXSAAAAAXNSR0IArs4c6QAAIABJREFUeF7tfQuYHFWd73lUVc8rk0kWWD4%2F1uuyLMuyiMKq66IiKJgwyUzPZEgUEQEDIqIiIiLLIrAsIhcR8QkKPgBFQ5KZnpkkyGYNZt3oRgRkc1kWWS43l5vNBzEkk0lPd1Wdc27%2FiqqmptLd093T3VM9ffr75pukpx6nfufU7%2Fzff0r0RyOgEdAItCgCtEWfWz%2B2RkAjoBEgmgD1ItAIaARaFgFNgC079frBNQIaAU2Aeg1oBDQCLYuAJsCWnXr94BoBjYAmQL0GNAIagZZFQBNgy069fnCNgEZAE6BeAxoBjUDLIqAJsGWnXj%2B4RkAjoAlQrwGNgEagZRHQBNiyU68fXCOgEdAEqNeARkAj0LIIaAJs2anXD64R0AhoAtRrQCOgEWhZBDQBtuzU6wfXCGgENAHqNaAR0Ai0LAKaAFt26vWDawQ0ApoA9RrQCGgEWhYBTYAtO%2FX6wTUCGgFNgHoNaAQ0Ai2LgCbAlp16%2FeAaAY2AJkC9BjQCGoGWRUATYMtOvX5wjYBGQBOgXgMaAY1AyyKgCbBlp14%2FuEZAI6AJUK8BjYBGoGUR0ATYslOvH1wjoBHQBKjXgEZAI9CyCGgCbNmp1w%2BuEdAIaALUa0AjoBFoWQQ0Abbs1OsH1whoBDQB6jWgEdAItCwCmgBbdur1g2sENAKaAPUa0AhoBFoWAU2ALTv1%2BsE1AhoBTYB6DWgENAIti4AmwJadev3gGgGNgCZAvQY0AhqBlkVAE2DLTr1%2BcI2ARkATYLzWABsbG2tzXddSSlmGYbThd%2FBDCLHa2try%2F0%2Bn07Kzs9N1HMc1TdPGbymlSym18YN%2FM8ZsIYT3nWEY9tTUlLtq1So7Xo%2BtR6MRmBsENAESQtasWWOBXPDT2dlpCSE8kmlrazMymYz3vWmahuM43m%2F8jRBi2LZtMMbaCCEdSqk2znmbEKLNMIxO%2FMb3%2BA5%2Fw3H%2Bd%2FgeP7iG9zdKafB%2FgxDCGGPeapBSev%2BWUuK%2Fr37pH%2BB%2FF%2Fwfx3gH%2BZ9XT3jtOvm%2FMca8QwNyZIxlQJCGYeC3R5xKKRBkxifRDCEE32d8MvW%2BJ4RM4Tv%2F32n8dl03Y5pmRinlEkI8Yvav57a1tblTU1Pe9YNjLcvCtdN9fX34HR5%2F1W%2FD2NhYR3t7%2B5FTU1O7%2B%2Fr60lVfSJ%2FYEgjMGwLcsmWLMTk5aU1NTTGQ1B%2F%2F8R%2BzPXv2dCmleqSUi03TXCyE6FFKLaaULuSc97iu280Y62KMgcAsKaVFKfXIj3MOcsN3%2Bd%2F4O4jPJy98j397BBWQTZ6BWvg7kCsIkDHmSaQgUPwfv0GunHNIp3nyxL8JIfsIIXuUUi9TSncrpXYLIXYbhrFbSpkGmba3t0tfgsW1ChLm%2BvXrTzAM4%2BuMsRcopdcsW7Zsd0u8yfohq0KgaQlwzZo1ILXXE0LewDl%2FPWPsLyilxwghjiKELGaM9fiSVlXA6JPigYAv2U4wxl4khIDMXpRS7hRC%2FD%2FLsna5rrubUvrSggULXjr99NMzo6OjWAsbCCEnCCHWmKZ5cW9v70Q8nkaPIm4IxJoAN27c2J3NZhcrpSClHck5P45S%2BpdCiBMJIUdQSrsIIcFPXnWcCyks0EADlTWkunrSYSAl6uPyKn1YRc%2Br8uG5C6vxgaQdeoEgBULFxQ%2FUc%2FzeI6XcQwg5DZsg%2FkYpvbKvr%2B%2BuuL14ejzxQCCWBAg7jpTyA5zzpJTyGELIkf6Cjq2qqdXg6kwB0Y0heC3CG8hsvlNKPS%2Bl%2FOvBwUGo2PqjEZiGQOwIcP369UcwxsYYYycHNjY9Z62BQFg6LkcSDNtdS50L1ZlSupZz%2FqPJycnHtRe8NdZTOU8ZOwKEba%2B9vf37SqleOByizoVyHqqex4ScrTDyw0QFY3z0xzPS4%2B9CiLRSCjaofZzzCSnlPjhXhBBHM8ZOgKe4ls%2Foj8%2B7d0htDHuBPe9yCKPA03yICaEeOPp4wekBjPLCnf8PjOuQn1o4mHBfxhhsiI8wxu5ub29%2FEjbDejyjvmbzIBA7AgR0mzdvPvrgwYO%2F4Jwf1SjV0iexNGNs0rcdTcL7SCmdxI9PZPib93fTNPcLISYZYxOu606apjmZzWaDY2G0n%2Bzp6Zk8%2FfTTwy%2F6tJUxMjLyccbYbfBChyWecl94jIMx9jyldJcQYg%2BldK8%2F5oOGYaRd1%2FViATnn0nVdaRiGR3xCCJCdF8ZjWRY834YQot0wDM8TjtAc34GEcSFMB7%2B9H3jNYZOllMLJBK942V5wpdRmQsgvpJRPWZa1d2pqirS3t5NMJmMg9rGjowPX67Btu8MwjC7btnsMw1gEh5ZSCmaQIwghr8PvqHZQyTqBN5ox9oBhGHcvXbp0e%2FO8rnqktUYgdgQI8kun018nhCwNYuKiMW8hyQY2QYRa7IUhPAi3QJgFwi3wA%2BKC9MUY2wdJjDH2Cn4LISYSiQTsQvhuH6U0jfPS6TTi1yTi1kAe%2BJQbglHp5Dz00EPvSyQSP8ULHn6Bw3axUCxf3pkCu5ZS6hZCyDbTNPfatp1BkHNXV5ddinDLGB%2FbsmULe%2Fnll9nhhx%2BO30ZXVxebnJw02tvbPdIEWSFAm3N%2BvZTyQ4XGV%2Bg7Suk213WXDQ4OQhquJOYPY0J4k5XJZBBjidhJEONxU1NT77As682IBAAxYnwVqNEYAyTC%2B5RS9yaTyecrHFcZcOpD4o5ArAhw3bp1R5um%2BU3G2NJyCAHgKqW%2BQwj5kZRyoqOjI5PNZiG1paempjKrVq0C%2BVXysjV0vjZu3PgFKeX14SDnMgaA0I%2FzBwYGIE3NyQeB4x0dHXcQQj5e7gCUUvDGfqXc48s97oYbbmh705vedFwikTjDdd0LGWPHl3tu6LgdSqnvT01NfUPbB6tAr4lPiQ0B%2BpLfWC4xw1vA4dCRQmqWlBIq6o0LFy78RjPacrZs2XLUgQMHflfIu11CinGVUpckk8nvzeWaK0SAMzghJpVS5yaTydF6jtsf1wVSytWEkLcEG0uZHmWYCZ%2BhlN5umuZaHTtYz5mKz7VjQYCpVOoYwzC%2BqZR6XyFbWFQlhLRHKb25q6vra81IfohvFELcQSn9SCVLQUr5cCaTOXfVqlVQ%2BefsU6kEKKXcbZrmyrPOOuuXDRg0Gx4efj2l9IOU0ksppVCNw06fmYYADeIRzvlNiUTiqVmaFGa6l%2F77HCMw5wTok8H9lNL%2BQobsKD6e21XKT9q2fU%2Bzqitr1679hGVZcH7A2VDuB86WoblUfYOBVkqAQghkbwwNDg421OEwMjJyvGEYl%2BWyRy6Cc6eYVlHE3PISY%2BwextitWhosd4k233FzSoBbtmxpm5iYuJFS%2BmmEhoRV3SJePYSUfKW7u%2FvGZt2ZN27c%2BHbXddcxxuDNLNuDKoRY293dfU4cnruYClzMew0CJIQMJpPJxxr9imCNpdPp04QQV%2BUCDN4ZrLMyx%2BFms9nHDMO4hTG2WRdXKBO1JjpsTglww4YNS4UQDyG0YibMfBvTPYZhXNmsO%2FLw8HAPpRTPe0bYUxrYPMPqf%2Fg72Duz2ezQypUrH5kJp0b8vVIboFJqzggwwAMB9oZhwORwFWMMaXLep5zwGcRu5vLMH3Ac56YVK1a81AiM9T0ag8CcESDsfkqplGEY07x2RdRgBBRvlFKe16wpTT5p3JyLI%2FxsOR7usLoG6c80zdVxIf6AAKWUiGOcRiRFnm2nUmpoLiTA6GuEdccYu0YphRAeT%2BsIiLCMjWgnpfSW3%2F72tz%2B44YYbdBB1YziqrneZKwJE4c87cyWPPlZOuhu8c4lEYnDJkiXP1BWNOl58%2Ffr1KxB4yxg7rBICxJCUUsl6e1ArefRqCNCyrMGlS5c%2BXsl96nXsmjVrutrb21cgNAdRB%2BE1OJNEiEBzKeWIUuq2np6eHXEwSdQLp1a47pwQYCqVOpFz%2FptyMgkQ5MwYu3j58uXrm3VCoH5xzn9FKUX6W%2F4xygnazQUbP7dgwYK%2FjNOLFlWBZ3oOlK%2BKEwEGE4DSWYQQkOBFQUpiBZsTsm9ucxwHzjhkB%2BlPEyLQcAKEHYxzfi9jbEWpDI9AHUGgcC4D4EvN6vH17X53Gobx4Zmki7A65qvAqKh8bV9f3%2F%2BM09qq1AkSVwIEpniWrq6u01zXvYYxdmq4CvdM6r2fUrfVcZybBwcHt8Y56D5O6ydOY2k4AYYdH6VSvnyQdjiO865mtfvhGUZGRi5ijN0Z5PvOJC1FbFKxlJwKqcCl7GiMsZ2GYcRGBS70Am7YsOFI13Wv9mMzUSl82mHFNi%2F%2FIFSbuZlzfl9c7LRxIpk4j6WhBIiQhAMHDvyMEHJq1AsaSHyhF2kP5%2Fy8ZcuWPRxnAEuNbXh4%2BG2cc5T2QhJ%2FWR7H8HFSyh%2F39%2FefFzfJogoJ8AUhxODg4OCTcZ9LhCnZto2wF4TMeC0PKvhsZYxd3dvbi3jH2KZgVvA88%2F7QhhLg%2BvXrlxuG8SPGWHcY2UK7qxDiO93d3Zc3Y6YHng12v0Qicb9S6owKc309aBDtrZRC7Fxd08eqWeGVBkJLKZuGAH2p%2FXhK6c8opUdVUs0b0yaE2IXgadd1H2hmzaWaddGM5zSMAFHlWQjxQ8bY2VFHQAF1Y3cikTi9Wb2%2BaND0yiuvXGdZ1heii6ICO%2BAzruu%2BO45xZ8UIsISa2DQEiLk7cODAZwkhN8JJV01rA7%2F50yOu614%2BNDSEKjP6E1MEGkaAfgbEFtSXK2Vf8UtQfXHRokU3xcnzWcn8jY2Nna2U%2BjZCXmaSdIuQBop3fqWzs%2FOaOGIwn1VgP2D6F4SQ48q1A5bIgHkeDpJEIvETnUVSyRvUuGMbRYBsfHwcNf5mLJ%2BEtKnOzs53n3HGGU25c6KidSKRQMjLsWG7Zsi2Oa2vSRGnyATn%2FP1xtX9WmglCCHnBj2V8qnFLu7o7%2BRv1v0YLKFQguUfnF5VwUHz1xmXLliGLRNsGq5uaupzVEAJEr1bLslK54pNHB09RQl36Un9%2F%2FzV1edo6XxSFHaSUd%2BZsXhcE5BcO9Sn3O8MwXsxms2%2BMqw0p7AUOQ1qs7JQQApsZ7JmxJ8Dx8fGPEkLuDq%2FTWWxk3mV8XJ6mlF7f19e3ts7LUF%2B%2BAgQaQoBjY2OfoZTe6jcVLzo89H5ljCXjkjFQAY7eOh8bG%2FuoUur2cMhLNWqU67pPDwwM%2FFWF92%2FY4ZXaAFG23zTN5JIlS3Y0bJBV3mhkZOTvGGM3VzNvgZRf6Fx%2FOKhK%2Fg3Xde8eGhpCfrT%2BzDECDSHAVCr1BKX0zTMtKoR9UEovbkZ7CbJbKKUIeXl9BdkE03rjBhKU4zjPDA0NgQBjqS7BUTA5OXmHUuoT5ZSYggQohEiuWLGiKQjQMAzkbHufCuM2ZzRv%2BA7%2BrZZlXb106VJUx4nlHM8xLzXs9nUnwJGRkVMYY%2F9Sjk0ld9x7e3t7f96wp6%2FRjcbGxg5TSqG3x3tq9OLsVUotiUPxgEIQgQAPHjx4Z9imW4oo0MOkiQgQgevfLSNONa%2FehokyUHlLfedvGnsppXf44TIv1Ggp6stUiEBdCRAvysTExG2c80%2BXyvrw%2F7YrnU7%2FabOlvPnS0OeVUjeGSb5ao7n%2F4kAqGHFd99I4hsEEEiCl9BNhwi8h4TeNCjw8PHyaaZqIVsh%2FZjmX06TCsJospUTjrqcdx7nXsqzRTCazu9nWf4V8E7vD60qAfp%2BP4Vxc8IkzBZQSQr6xfPnyT8YOoRkGlEql%2BpHbnBv%2FtJCXWjwHSrM7jnPjwMDAtlpcr1bXKESApa6Ngg5SyuTAwMDTtRpDva6zbt26o3L2yieiIUz1ul%2FouvuklBsZY5va2tq2NWsURANwqukt6kqAfgmoB2eqwousB0rpmmw2%2B5tEIuE9IKV0mm3Eb6h9yPdCCIlzstmsdx564AYIRa%2BB79Ef1zRN73cpJA3DKPp313W9RFGlFKOUXsU5PzYs4eJvMxF%2BWGUsdi7sQzkpC%2F1%2B7xNC%2FNQ0zWfjkGsadoKU%2BRxNQ4Dw5LuuC3MG2rLWXQqM3gO9ngkhewghjymlNgghtnPOM4iPtSwrg46Hk5OT6Hho15QJWvRidSXAVCp1P%2Bf8Q7NRIcIqw1wsyJkcNw1cNyDCX05NTe0sds9EIgFCBjEXPAQN0R3HIdgADKO8NFecg4vhnOCDiimEkFMIISeU8%2FzNJAH63vzPKqXgCS4PpHJAqOIYf9NHT%2BsJKWWGMbZXCIGGWPjZzTn%2Fb0LITsbYrqmpqRcXL168O46B81U8esNOqRsBwjHAOX%2FCdd2jAoko9AJ5%2F6y0Nl74%2FHKIaTbEW8m51T5LNR7GaFxheKUU8sgWW0nFQjWqmZOZniNXOfoltJuklO4qZ2XPJJ2Xc41Cx4RJvNQ1pJRHK6WuDlo1lGG%2F9i7XyOP8%2B0FLyf%2FApkgpRWUaxF2iEdX%2FzrUB2Om67t62trY96XR6n2mae7u6uvZponx1BdSNAP1KKJuC%2FguVEEqxXOHwy19PL13wcpR7j4AAqwl6bvVzo6aCMOblhNg0knRmG940R88GgoT0CBvjBCEEPygyvNt13d8jS8eyrOchQULF5pzb7e3tUK%2FdViDJuhEgnAOUUlR%2B8RoeVUuA1e72%2BrzmQGA260KfO7v3KkLobq5FxW4QIucckvrOXIP5%2Fwup3XVd%2FHvXfFSx60aAw8PDF3DOURAg3%2FtWL9jaLdi4mgPiZJrQY5FFQ3DC22OJtFQX0iN%2BlFKQDidR2gyZPUqp%2F8hVOX8%2BnU7vNgxjQggxsWjRoolmK19XTwL8HOf8lmgtvGL5osXUx%2FDx9bBP1couOVspV28OzSGx6lG%2BhoD%2Fzk5AcuScv4RaiLA9MsZ%2Bzzl%2F1nXd5%2Fr7%2B4OUv1hmvNSFAKOpUlpamb5otGQyO8lE4xdf%2FHxSRDm3II0QYT1QrZHd9KiU8leEkCd7enpejIONsS4EiDixRCJxJ%2Bf8Y7Ugv7jvujN5QWshZbbKPeoRTxnVIvQ9XiWnRuPivwdpqNBCiCeVUg9yzrf39fUhrGdOJMS6E2AtVLtaXKMcm0e1kkUtSD7uz9iI8cV9o9Pjqy0CfpwjekXfn2s%2FcM9cFEGpGwF2dHTcESTLz%2FblaZZQkcAOWGkYTbnhNvPxuLjadVtF4o6JdoKwm18KIW5qdHvRuhBgpbmi5e4rsyXSaiW8cu5bzjHaUfLqTJfwOnp%2Fn49ErzfF1zTcYvOLavC2bV912GGHrW2UfbBuBBiuAhNe1GEpqZzdP0pa5ZJlo4%2FTBFhdiE80kDksec2FnSoamB3WPhptM2vRsbhSymsWLlz4jUaE1NSTAG%2FlnH9mtvaxqCoSDpeJk6TQaMLV99MIzGMEkP984%2FLly79Wb%2BdIXQgQWkwqlbolV7nic%2BVIeeVKiPVUYWerns7jxVjXR4tKztr2Vvsq1E2KKQKvB%2BvdGKxuBDg%2BPn5Trj%2Fq381WjQm%2FfXGS%2BKJ5nfX0MreKeh1X6T6u626%2B2xWVUs9KKc8bHBzcXq9duF4ESDZs2HCTUurvY%2BJlqqryTLk752ylx1YhuNmaQzTOpZ1IcdaQql3jruuOPvnkk%2B%2B%2F4YYbkJJX80%2FdCHB0dPQLuWozKBOfH3S5hFLM7hdXo3DYsaO9mK9Od7VSUy3WS6WOtnJNMPq4Vz25jZwj1EFE0eG%2Bvr5v1cMeWDcC9NsL3hRthlRzCo%2FBBasldv2ivibRRE0dYXU4eOn0d%2Fn0sjxclebWNynOzxBClvT39xctBlwtDdSNAMfGxj6nlMoXQ6hWIpiNNNGocxt1n%2FmIYViqDy%2FialUmrSbPTzUZoTH9%2Ff1fqpboip1XTwL0mqFLKY35Hj%2BlX9zXzByagOYnAcVgje9oa2tL1rpZVN0IcNOmTZ8SQtxOCJlVX4VmCZOYrbd7vm8SxQKctTf9NWqph9TraydIu83vUs3oLEFNQiHEpYODgz%2BopRRYNwIcGRn5uGEYyAe2ajWx0ayBsLQRvsdcHRdMTK2etxWvp%2B2ps4oDdIUQXk8QpdRLfne5NLrKCSEgiFic826l1GFKqSMJIccQQnoCO30TYP9of3%2F%2F6c1CgBcxxr4J0MNG7EolnbmWEF5NXZWThJBJpdQkeiYIIVzXdTOmaVp%2By09DStlBCEH5%2F66gDagmwpnT46KOjVou7ha4llRK7aKUPksp%2FZlhGNsYY2ipmf8cPHjQ4JwztI9ljMn29vZ8Uu7U1BS6CB5DKX2vUupUSunrCSGL44obYwxNn%2F7HsmXLUF%2BwJp%2B6SYCFSuLXZMSNu8guKeWvUcARC4wQssswDHTamujr60NMkreQtmzZ0jY5OdklhDjCcRw01X69YRjvIIS8nRBybLQiduOG3xx30pvEzJtEIU3Ar6f3EKV0vLu7%2B9l9%2B%2FYdJ4R4p2mabwSpEUIg4YHMsClDCPGaI%2FlNkfaAODnnzwghfksI2SqlTOeu9RZK6UpK6QBj7Ig4aiC5Rk7nDgwM%2FLhWq7tuBDg%2BPo5%2BwN%2BN9gQJpMEwuDN91yDRHAsEzV%2B2KqWGCSGPMsYOk1IeZRjGcVLKP%2BecHy%2BlPEIp1aWU6qCUoozPBKUU1W6fY4z9J2PsWcdxnkeJcNu2QYbnUkpPI4S8%2BdUQqteKUcZNhZ8L00EcTBdz8dxVzj0IbDul9OuO42zlnENiS3LOBwghR0spQXSezT2qOZXAGWsYsXa%2FdhwHhPqor918RCmFtYtNvJLrea92vTBVSn2vq6vrklpVi6k7ARJC8k2RqmHteqvA0G%2BxG%2BaktR9LKR%2B0LGt3Op0%2BMZFInE8IOY4Q8gbspNHgz2LBoNhJGWMvCCGedxxnmFL6yMKFC62pqalepdTF%2FjWhOucXSoBLq34XvDAzbYQtfBw255cYY9c7jvMIIeQIxtgnTdM8DRt0rXBBK0yl1A5K6bDjON%2FDfRKJxOpcp7gLfBOPt1QbGQgdfTYp5aOQUvv6%2Bqap%2BtVwC86pCwH6JfFvopR%2BhjE2zQtcqcpTLCskuitVQyJSyr25He7HjLGbE4lEx9TU1AeRexjseuXeo9SCQFNwKeUopfRuKeVzOXX6g4yxK3wD9Jwupkqk8Fq9ZKU2krDkEF7Qla6Z%2BXSulBKk9BMUC4UqaxjG5YyxD0GwqBcuuK5SCuae2x3HuS%2BRSLyTc349IeTkuZ4jQshziUSib8mSJQiOnvWnHgTIxsbGPqSU%2Bma4J3C1O0c9FjMWFSrQKqWup5S%2BgB2OMXYepL0gbrHS%2B5ZajD6J72aMPSyEuAMGac75ZTlv3YcZYx31WsiVPsNcL25tHnitT4ePBcwot1qWtZZz%2Fh7XdSFUvK5RphRfNX7cNM0rcsLMhG3beF9WQNWuQMWuqUoMk5MQ4sxaFUioOQGmUqkTKaXrGGPH1MK%2BE71GNZJeRHqBHeV7lFLsqG8WQlxDCDl1tupnuWlaUI2VUrdblvWA67oXEEKuhaoRJqsWSW%2FKq1MNsvHOufpWicSNRuRSyqs4548goypnW%2F4gIcTbLKsVJqo9F5WapZR4X9Zwzm9EqwtodtVeb7baBGNsSW9vL0wBs%2F7UnAA3bNgwrJSCUbZmn1oQqQ%2F6PinlZaZp%2FlwIcXkuTuoTftjKtDLtlRpww5JTOWOFrYUQgoWNMfQopb7PGDs%2B2NkrvV6zS07lbh6tchzUT9M0V2YymUnG2N05zQERBXkH2hxtlhnG2F3I7rJt%2BwOmaSLLywtxCwsljZgjQsh5y5cvf6AWBFNTAoT0xzn%2FTRD7V4sB1kotwy7GGLsWvUmVUjdzzleFxzkbNbTa5%2FTDbK4UQiCmEB5zz1Nc7fWa9bxKN5xyNpkm3hR2YnNG60h4exljp1bwvC5jDH1490opn0Y9PcbYfwshJhOJhOG6bjel9E%2BUUicopY5mjHX7TkpW5j1sKeVdruvebFnWVVLKTyDKo8xzZyVkhO%2BhlLq0r6%2Fvrlqs95oRYL0aIUUJsJqXxW%2FKfGEuvulJSumDSqlTqrBhQHWGvRAe432wjyilDEopIuuPpJTCW9xTqXoipUTozWop5W7DMCAJvqUSVWm26sRcqTFhSWEuvYpxwhoxppTS1Uqp7YyxDYSQE8ocH%2FpoPCalHEskElsPHDiwfdWqVQhvKfrZtm3b4r179yI86725c5fnzEIIqfE%2BMzj1EIz8AOf8CiHEzZRSaFFBE%2FRGOfWuWL58%2BVdjRYCjo6MAEPFzJ8cp1xBkRSm93LKs7a7r3qmUel8UuCLSH9TUFw3DeCybzW6glG43TXOvbdsZx3HcIKKec25kMpk2xAYyxk40TRML6gw4VKIxkIVwwVig8iilLgS5YuEzxkCm%2Bc9spNNmOrcQKbbKd36Q8o056WytUupOxljvTHZpZEYopbYSQu5G3Go1DcYRsWGa5utM0%2FQiIBCmVcZ94Zm%2B1nXdNZZl3S2EwHr3NJeZzo2SbDXzSwi5vL%2B%2FH%2F1CZv2pmQS4cePGt7uu%2B0%2BB5zcquYV3skYRpB%2Fj92Up5S2GYfyQUtpfDrEgh1JKeYcfZf90pUGX2Axs2z7DNM1PUkpPjOZaFloojLEdjuOcZ1nWsUKIbwcpSY1YUHG5RytLgogXRXwb1mpOG%2FgY1kwp6dzP871dCHHX4OAgNBLvA0JD4H17e%2FvxlNKfRNPGNm3adFo2m8XffplMJp8KvQ9s%2Ffr1x3DOIdXhPcl7egtJeAghCzZtSik2bc%2BR1wiNIpYqcCqV%2BkjOvnBvVISeLRHOkuIRP3WlaZrXua6L3OSSlWn8Sb0HRRzCC2dsbAzetyBx%2FLFoB%2Ft169adzDlvyxmHn1m1atXe8GJsb29HRD1sOgiqLtoTFy9%2FLsTgqYMHD56eC6S%2BwLKsW2cbQ1kO2TdqM9JjKV4yDJEBUsohIcTJlmXB7oe8cu9TQIKHG3ibbduXrlixYgeOgflpamrqLZDgpJRnE0IO8zfx0wcGBp4OYz8%2BPv5pKeVtENaUUk85jnM%2Fwmz6%2B%2FtfxO1wrYMHD36AEHIrIQQhN%2FlPdCwYNwqVQqtijN3RwBz4%2BDlBRkdHUf4eZfCLAjYTARQ7t0q73z7Xdf%2BtOFlVAAAgAElEQVSGcw5y%2Bq6UEirqtEUVmlAIi88qpa7u7u5%2BBP1IsRAmJiaO4Jwvd10X%2BZFHU0qhqp6TTCZhB8x%2FUqnUt5GOJKWEjRBOlnu7u7tfDK6zf%2F%2F%2BYxljX%2FfDbUoGhgshvkIpvRNjFkJgYRV7EUqSaT3mocRLWZOxNNqYXs26qsJ27KmFxZ4NmFJKr5ZSrqeUjkVV0PC5fvzqZr8sFNYaeu8cqZS6Mrd%2BESZzZEjbQAB%2BQQIkhIAAvXWIa%2BYcgnCY3JZOp9fAdoi1v3%2F%2FfpiKEMsLU06x1DZkUd3ja1jfzUmVZzQCU8bYYG9v70h4jVf775qpwOPj46j88vFqB1LsvGpEaiklvFU3SinXGoYx7IeY5IkE%2F4ioW48iPCbYLSHxua4LD9dqzrmXC%2Bkvlu2O4wwNDQ1ht8x%2FRkdH4cG9KHTcHqgftm3fMTQ0hF2SwOj8hz%2F8ATYexFB5rFbIPodAT8dxzrdte297ezvGvriZ7HiVkmSUqAvMjXfIPFaPX8it0Tc5jnMj5xzSWdHnVUqNE0IuCW%2FADz300PsSicQPcyEqR4bP9TOQihJgNOBfKbVZSnl%2B%2BNojIyNnMMbuZYzlHSTR8SH10zCMPn89%2F3N4%2Fusxb3hthBDvHRwcfLQWXFMzAhwbG7uXUvqRWr%2Bs1TxkTiRHWSCoFOhJ8pESoSXYwZAEPrhixQrUT%2FPmbO3atR%2B3LOv2QKQvhwBzDhOo2PnhYmellCKC%2F5Le3t4J%2FGHjxo3dUsrrcl7pT5UKwZFSPu667llQ3ZVSIOI8eWuV9dVsiShxNuN3ubax8NReZRgGHHQ%2FhSe2mKMsp9ruME3zzKhNz9dUel3Xvds0TUiAwVopKgFCBQ7MK1B9UA3GcZzVwWYdwpZt2LABOewYW9GMJSxtIcS5hmGso5S%2Bp9YcEJGeJw3DOLO3t%2FfX1XBD9JyaEaCvBn6sUgmgUrDKVJMusW37UcuyfhfOmYyei0UlpTwnsKUEYwdRua77fUIIArrDAaglJcDI7rgDiyJiaCbDw8M9pmnCa4c4xDBh5nd%2BX4K9wrIsECGkQJQ2ypNgPXbWOEhYtVjQTXYNlKOC9IS0yE8VayDmS3MXDgwMbCz0fH4I2oBSCkHTXj2%2FmSTAkAq8HVVfksnkc8WwS6VScAhiIy5oQ4ftnHN%2BLgqtSikxhrwNs9bzgXAxIcRZg4ODT9bi2jUjwPHx8ZvRCN0Hf852aULI447jJC3LunEGiXQPOs%2BfddZZvywEpC%2Bt5T1y%2FnPNSIA%2BkfzStu3VK1asQB3BQz7r1q1Dia0HOefvLLFhgJyXOY5zVSKR8GKt5hrbeklZlW6C0Y2jXuNqAOZfTqfTt3R0dPyfsI26wH2vXb58%2BRfxPepPwrZcaF2NjIz0ougG5%2FyoUgQYSIBSyoehUhfptsa2bNnCEAGxfv36IwzD%2BCljDHGD%2BU9EoFjvuu6lhmHAI5yPZa31mpVSPuO6brLYu1UpKdaSAD8K9p9j6QQBoTc5jjNuGEaKUnpUIcnGL%2FvzpWw2e5MfMAq9IV8pNwBxbGzsML%2BxE6pvIO1nJgLENXYopYZK7KjevYaHh0%2FjnP8s7DkL7usbnaVt2%2Bd3dHQ857ruv5YTShPGvpr4qrkIhylhYC%2FpPKi1M2IOroeq4u9WSh1rmub3SzgPns5ms0tgd4bDY2pq6nrO%2Bd2Dg4MIYZm2ZiEJptPpM4QQP8IaL%2BYEkVLeSil9zLbt90ft2VhDCKWxLOvDKJ%2Ff1dX1NZDg8PDwAOccqnDBQgiEEBRU%2FR9w6OSqp3%2B2TE2t4uwQKWXBd7BS4guOrxkB%2BgbTTRCt6%2FUiBbtJMZKF69%2ByrCWZTOY9jDF4uooZz0FSp6Om2Jo1a7ow2bZt37dq1SqUvp%2F2gSSICi5KKRQueKyUE8RPbVsdDT0ILrhhw4alcG4ElSxGRkZgvEZFmHz8VJgEhRCo9rty7969T5im6QWohokteL758l1Y8pnjjXSalFOPseTy5ZGVlCSEoG%2FOiiL3cA3DuKa3t%2FcrILvR0dHP55zGKEbwjFLqvKh5JRj0%2BPg4Krag9uQh0t2GDRtWIaqhs7Pz6iId1lgqlbqAc46wlolsNjuE9eq%2FB7DxIei5YLyfUup8wzBQB%2FMXdewzgopK54RjH6slP5xXMwJcv379Cb74%2B%2FpaqzTlPmAuIv2XqBSRIzdMwDQxPHQNZHhctnz58u%2F4tpPPI6o9F%2FP0HcMwrgscFuF7rlmzZnEikbiWUno85%2FzCqCE6lUphR327Ump1EckPxuSPwCnDOX8KOy8mcHh4%2BG2MMSyqaZJqsMD8mmxDiURiqe%2FVnjPTQhOrmdPILA7P4b8f3xJC3B1UTgrmPDw%2B5K9TSt8BFRW2Y845Ko4fgfOllJAALx0YGNhW4P1gGzdu7Ort7Z1cs2aNkas8dIwQYgLSHqQ7SHGFNnvfAfhpy7LwPqAIMDyuP04mk8gQIYj15Zwj2iNf5Dj8rruui9qa1yil%2FikcPVHo2ar9TghxX3d39%2BpKkxOKcUjNCBDqolLqoaidoFzyKnVcuYSam9gvCiF%2BSin9Z5SzLwJyvr%2Foz372s%2BOy2eyYX7oLub1fY4zdGA10xnUgKZqmeUxPT88OgI%2BFtGrVKpAp1FkvdW1wcNCLzYp82PDwcL%2Bv5qADl%2Bs4zsrBwcERv3Ds%2FX5hhkNeVHiSpZSXmqYJw%2B%2BP%2FOT12L3Q1S7mQnNe7lw383FwcgkhkCX0PISGaPGQ4NmEEGuTyeRK4DQyMnKRYRjfDTDDMY7jPAMpspQ9bGRk5HjGGN5L5BdfXmiDxzUhDPzhD3%2F4gGVZ345kc026rvtniJLw011%2FhQDpIt7qxxKJxHnZbPZmxhik0Jpv2Ln8%2B39MJpOIpKjJp2YEiN0jlUrdjlim2b4Q1QDne06XGYaB3giIps%2BX6glfD4HGyWTyKl%2Bl%2BAIIL7yocjvf14QQ15cSsf20vzullD8cGBj4VomZAPldxDlHVkdPMA7EXE1NTQ1iF4ZarJTCS5CP7QiPF9WAXde9xjRNHIOSWfOaAGuyqmN%2BESklgvT72tvb3ymEuKXYcIMGQH5UApwQS6PHZrPZZzo6Oi4u5swDaSHIOefw%2B11nZ%2BdXCjlQfE3oU0opJDOgidK0j1Lqk319fd%2FAl6lUagzJAUU2r72WZZ0Fz7ZSCg7Rmlc2gvqbTCZ%2FUqspriUBIsQDhn1IXwVf5jDRVKuKFHtwVFURQiQNw0A1jXzsXPT4dDr93lWrVv0c3rR0Ov1vSqkTI8egh%2BoPGGNXFpIE%2Fd0Yiep3oo9If38%2FSoUf8sGi2rdv34d88svnSfp2vN1IfYL6kkqlXkcpxa6ajwELG8RRgSaTyfxFW1sbHCboARGbBjW1Hst8JPcimznaOv6NUgomkQ8XEhhypabQue2sZDL5GKQ4X1JExfJD7Nq%2BOnxOMdsz1Oeenp5MEe8xNmk4PBD3GoTQTLuHEGLNE088cf4NN9yQgR2SMeaRdoFnQ6Xzvmw2CwkRWSSeEFKNQFOMK2zbfmM0bG02ZFhTAgTjj4%2BP%2Fy6XgeGV8alVbFk5IMI7hEZGmUwGu920HSpEKOh%2B9UcgNl%2BKg8s%2B3wc1MlFfZozdVEhl8FOFjrUs68UiKgVwQGoS0t%2B8ElnBM%2Fi4wHt3JUr6QLXu7Oy8P1xENhxPiEBVSukC1IbLkfxHaoVpJGYxOr78mmr0cRHyn%2BYJjuCS%2F1uw1pro3GBT%2B6egGnn02XxbcRJmlVQqhTz0KymlBePwUBUmm83eOzQ09HgBMkCRg8Nc100XsvsFub9SyncXIxJK6e8553dhrW%2FYsGG5EAJmo2mOkAB713Uvw6bNGHuQENJd7Lhq5hKe5nQ6vWimUl%2BVEGKtCZD47TCn2REqGVC1xyqlRl3Xvdw0TeRT5uuoha%2BHXqrJZPIkfJdKpfo55yjqOK2qbej4vbheEfuKZ2Rub29PFzLGIpWOUnqHlBIFTot9HvalRzY6OooYSuysBYnHcZyTck2v36eUQoJ6zTaWRpNbgY0gNsRbbGyRjatWG8NT%2Ff39b0qlUv8ZOAuic5FrVP5zQsj7%2Fe5nDM6MUu9GYI8OH%2BPb5aGpwMySRpOjwcFBlJGKhnyVvP7hhx8ug3UervpUZP38g2EYm1zXzQsXtVpn6AjX399%2FerUcUei8mhOgn%2Blwr5RyWhZFLVTeUkBCHSWEoL%2BHZ6QtQhTr%2B%2Fv7h%2FA3kFTUqRAGCA6Irq6ufVGC8%2B0x2I1PQVQ6pfTaQoGkwMGyrKItQQ8ePGgHlWNGRkaQH4xwiGkliIKXD3FglmUdxTn3qu3UUqWY6%2BvNR0KfiTQppdu6urreffDgwf%2BSUnp5ttHND3m%2F2Wz2nCLe2oIcgE1dKQX721WDg4MTo6OjCKBHOFiwye9yXXcJVMhUKnUqIeTczs7OW4uEwxS8x%2FDw8Js55wh3y6fdhZ9XKYWQHZSeQ16w54isodbyD8VMTtWSYs0JEANBwKbjOIhx8wolzjYuMCC%2BMJjR79AwGV2rcr0U%2FlcgeocnBv%2FOVW6%2BK5lMXlouWH6e5SlQY7PZ7MMQvZHxknO4eBkveC7UcZNSnoudGrtjLp7w6IGBARhpDwmsLnbfVCr1AZQSK1YGiVL6fqUUPMJoNjXtMs1OhmG1dQ6CkSsOxA1vGNXaQJF7m8lkzuzo6Pg9bL%2BFMKCUjvjrCiXuy%2FqkUik0Nj9bKfXu7u7ubQcOHIBdD3nngbo6mQulOWfZsmUbx8fH4cT7GKX0nL6%2BvrVl3eBVzQlNz0CAnic4igGciEiI4JxvoZR6ITuFjqv0O8T4Gobx%2Ft7eXkjGNfvUhQADrxVE7yj5VbobRAEsZjuwbftrKGCQ29V%2BD%2BNroeOEEF9NJpPoyVvWx4%2F%2FS6FrmxBiaNGiRc8cOHAAdpvTQraNna7rLsOuOjo6uiWXGP4213VPqiRVx4%2Byvx8NmoKBhW0nQogL0bBdKbUpTPwBCTfzd62YCYJiHX19fe8aHR39r6D6d4F1vtEwjHOKha0UWsCwFRqGcVxHR8dmODzGxsZAhqhU5EUgIPc953BbgoovfjrmyVLKrZUEFT%2F88MMn27a9KYhHjBJZbg1%2F2XGcH3HOURx5WihatRtGIGigYGwleJTzkteFAGcy7AcDK9c2EN51ww8VBjSXiP0N9FA1TfM%2Foq780HHfWr58OYy0ZX0Qp9fZ2YlS4Ytz%2BZX3APyRkRGv9FWI2POpOZDkOOdvRNOlYh7kQjdGdL4QAv1AChbChOtfKTXhl8ufVxJgSDrxnmu22kIzXM913R0DAwNvHBkZ%2BXfDMDx7dQEtZ6tt2ytDVYrKWrPhg7B%2B0UTdNM1Bzvke13W%2FWyRwuuxrj4yMoJ8OIj28ZkjhDRv%2FVkpdZxjGo47jwFHiOQDL0eBmOG4SGSkrV66sSSvM8MPWhQBxg1QqhUwMFEl8c4FdwhtDOepbOcf4D%2FQDIQSyNZ4Il%2BcOS5yIqevr6zun7Nl%2B9cBA5%2FRm2985b0ep%2B1wFj71CiKtCi2raseXeZ3h4%2BKOccy92sdCmAAkTzZc45%2FCs5bELE0Z4AVUqZc%2FlueWug3l23M5MJvNXbW1tCFD2Yvui61wI8Szi6aBJ4F1CxghKUoU1g9D6AkFcUoQgPAdH2JERXpcw8xw4cAA9f%2FP1LKP3gM2SELIaZh7fXPNgsXfacRz0ttnHOb8%2FEETKfYeLHCcZY%2FcppS6rRKgo992rGwFiADCYUkovY4yh9BMqMk8rBFqpSFzqeETNU0qvRBoOpRQVmKeRrE8sv%2B7v7%2F9b%2FAGFJBljF6KpUSGwcgVRkVd8SyEHByRcwzBel0gkJqJpcbgWdt62trZrpZTTApfD9%2BGc%2F6qvrw8GY3iBEUv498XKITmO8zeGYbwNoTDlTmyzHjfLl6XmmQf1sLnmiuKiVt87%2FNAW9P%2BYNl3%2BWp2UUi7B5rp58%2BajM5kMTDHToht8rFDTcnzPnj2XXHjhhYgvjH7YunXrYK%2BbLKLqsk2bNp1i2zYcF2iVWWgs9yxYsOBSOAT9tM%2FPFTnOzWQycNghb72oU68CTBEF9nhHR8f7K3HUVLL260qAwUB8z9FgrjAyymxDIpzmHS216Ct4IVCK%2FmLDML4ZdH4rcO5EZ2fnH2EiUbwBBRzhMCl0D4TVIA0tWv4%2BeCa%2FLBEKWh7i7AABdnV1fd4vfhqUHp%2Bm3lFKr%2Bvr6%2FtHeKN9Ow3iBgtKxY7jLGKMXcc5%2F0xYAqxgIR2yqON6brlmkWY%2BDlW%2FOedwbMEBUrSCEjZ0bJJYaxMTE8gb9gpnhNeAUuoB9L0ppir7vbo35dorbDNNc3UxGxpUWyHEvUHRjcg9kslkctTfrBFl8bZC2oefu95nmub5uWwXLyOs0HHlfscY22qa5iVLlix5phJSq%2BTYhhBggAMCMjnnyHhAp%2FszseNIKWEoRY7stATrMEjlLHZfZRgyDOPycHXm6LlCiLciut5PLv8N8oAD4vHHiUrOsGGcW2xR%2BXYQFIm8P0gRioLu20GvziWhfyZaIBIFJBHiAJXFr7WG4g1e06ToB6E2CxYs%2BJP9%2B%2FencpWDeyuZXH1sbBFAW8mrHcfZjpi5Quln%2Fpp8dMGCBWdiw0bKZG7tIrYu0KKw%2BY4LIVaXcmIgFY5zfmcmk%2Fnt4sWLv1ysliDIbXh4GB0MUZwjLwlKKXdRSv8c6icEGdM04QT0nBsF1upWFAQJCyGVzADSWaE%2BK6VQlQl1Oq8pJoBUct1SxzaSAKPj8CLU29rajkboCOccZPgmqK%2BEkGMC0ohKZyXIEIGeZ7qu%2B3Z0VAsq3kZ3TMdxrhsaGvpHDAZ9THKFI70%2BJiGVuVSRSO8Z%2FGh4FDH4zrJly1D%2FrODnhhtuaDvppJPQ6%2BEz4R4MyFqhlC6DTcUn018E4y1A%2FBs556sReoDA6hoYlL2xxsXZEJVEa7Ww434dIcQDbW1tN%2BfSHFEYt2DAPNLhUN5t6dKlj%2FtmFdi3PbMK0tOw2RczwaACzMDAACQnGS7cgcgGznlPgfL3HmSID0RTL8MwIBigGswX%2FeIDMNVA9YW9sFhQ9rdQa5AQ8m%2FhKublzAXWtVLqq5Zlrctms%2Bi%2F%2FVwtMz6KjWEuCfAQQkQF2pdffpk9%2FfTT7KSTTjoKxAiCzBUd%2BFOUjEKJHjgDKKU9uaIG%2BN0d2BZ9orwiZ1T%2BdTgK3d9Jwy%2F8r%2F2Cpbt84zK8VWgog%2B5Y46ij5kffTxufX2zysGXLlnm9Q9asWQMP1yQmya8UYxTaiaHiCiEQ6HyLX1IcKvOlKMflF5BAR7mPFtlRcewVfu04GMy9nOL59qnAzNEUNr7w%2FBR7NkLITkLIu5RS13DOP1bCAXBXOp2%2BAuvMD2v5tlJqo5Ty8kLrza8wdEuuxeoK27bPOvvss6epj6Ojoyh6cLmU8kpUJCq0lnyTFYqqQhJbCTu47%2Fz750iTsGnzkSvce6ZhGDApTYtXLWN%2BYcf8ASHk6kLvXj3Xe5wIcKbnhDero7Ozs8t13S6UEKeUdjiOg4Kmiy3LQtDl8wcPHny0o6PjN1LKfAHRiFcr7brueStWrFgPckISuJTyIinlZsdxLi5UIRc2mP379yMP9x2U0sujkzQyMvJ3jDGQ9DWFJjCQBNFXwS9m2QfRHuW4YNwOp0NFJNY9QoiVnHMUbEBQ6yH2xAC0MhaZd6g%2BLjYYIMcbBVGhDiOwOP%2BJOPtQFOG9KH7qdytcZRjGeKF1ho24ra0NawwVjvaVaouJkvl%2Bi1eomoekxm3cuPFttm13DQwMbPZz%2FD%2BFVLqgYXsBGzKyov5MSokNvWCBh%2FD6858R7yI6LP7Qtu27wj21ZyKDWv29mQiw7GeGp4pz%2FrkSL%2FxWSulZsGugGgvn%2FFohxM2F7A1%2B4QOI%2FigSuaNURWioNcUM0iDRAwcOfFQIsTPYeUdHR1FVA9dmRYhpK1oOuq77bQRfhwGIEGW4cdM0nILjlFJ567lS6hDpO%2Bo1D7DzD5yprNEhf69wfNPOD6v5he5fQH2fdn6BMKCC4w%2BFcnj4l%2FgUxTc6vkI4FtukgiorJ5988r8HtuhCaxbHZbPZ1aXS4nwVGcT3aT9Gr2RfYJhkIIVyzi9btmwZ2m0W%2FUAihG0QZqpC4%2FPX7pfRSIwxlgrb1UN4AOB9uda5L1FKn6OUQjL91eLFix895ZRT9pb9ctf4wHlJgMUqvQA7f9GjfwE8bFBDJXbWQjFGvvqKBQU7H9TtmXqCeGr0okWLVheaVJApxuB7oVGoEh41r2JGgd0R0trl%2Ff39X0NqYSaTKZkMP9O6ME1zJhKb6RIV%2FV0I0bD7SSm9ey1cuLDgGPfv33%2FI99FjCx0TnBQ%2BFscZhlGTZ3NdNzM0NLRrbGzs00opmEgKlo9C710%2FagBhU4d8fMkPGzTS3oJYwRkJ0F93OxGq1tHR8XCxwh5KKURLIGysYD9rlKKDWck0zWcdxzlWKYWeIp5T03EcFA1OoyK1YRgZzrlNKU0XKyRS0SKrwcHzlQC7EddkGAYKMkwjl9D%2Fn%2FPrrRVsB%2BiXCfqElBKVWoJFVZQAI32Bf4CE9GL2DD%2FFDqqC1xqzkPRHCNnV1tb2rnrFP9Vg7ehL1AiBdevWwQkIWzQ2xWKbIYLu0Q5ye%2Fi2kPxyZPI5ZGBEGmyVJEA4MoJ1l8tsghp6fjTP1pcqEcVwSP2%2F4Fxfcs7HCdYIkoZdZl4SINDzvav%2FUqLXKgoZbGaMnVek2fTNfq%2FWcHhOSQIMSZjwaKEz3cXRa2NRdXR0oKACFtY01Sukunnd7RYsWPDFWvU%2BaNiK0jeqCoHh4eELTNNEFaVpSzYc9SCEeF4pdYlvl%2FPugwowKKQRrbxSbl%2FgYANGtgdsgkHgP9YpzEimaV4bhKgVisBA35LOzs53N%2BtGPW8J0E%2Fxwa76vmBRhSfQ%2FzfijpBBAs9vUHWDjY2NfQj9VaNN1ctQgcOLH8bt7zHGrgiu7bcbRB4xdlSo1N4n4qQBeT7f2dl5ZrMuqqoYoMVPglbQ2dn5oFLKq6AU1gwiTpFnpJSfXLhw4aN%2Bb5qujo4OrHG0eUCmCDKuSjZGD%2FoCv6p8yL1KqYfh4Aj63aCYiW3bqKp%2BdVAyLizxhaRUW0p57cKFC7%2FarBv1vCVALCDYApH1JqVECE3RjxDiO0KI64LAZ78C73UIJYg0iClpAwzdAOS3Ff0eQgsV6XEfI4SgYcwhfRdC59oIU%2Bjr67urxTmh5R4fXQI553AiHDnDw%2B%2FhnF%2Fvuu4Pgs3VL8KLwqfLpJTvQ%2FVoKeV7o2Xyx8fHkaEBDeQZzvlG27bHwmo1AqcZY0jNRBvYkrZO13UfsW17qJKahXGb1HlNgH6zl8%2BgOksQQlJoAvwYwJ%2B7rntVMpncgZ3RTz%2FCjnpxTlV%2BJ%2Bq2EUKeLuEFhut%2Fl1JqhxACsVrbgjgtZHtwzm%2FMeb8%2BVKJSjTc0ePwOP%2FzwS%2BfSMxa3RdpC40ErBYRkoaybJ8kFn6j6KaXM5Mrp%2F1wpdX13dzc6FeL%2F6O6GXjc9rusekc1mn4%2BSEwjOdd025LoffvjhE4Hktm3btsWvvPIKmqrD5v2GcMhVoKWEx8IYQ0TEeYODg0828%2FzMawLExCDlzTCM%2Byml%2BT4hRcR5qJ7Pcs5v6uzsXBtKGWKbN29%2Bw8TExPGmaSKKfiSaT4nMEKi0KHPU3d39bPhcJJo7jgM7Sr6jV4ng2N2O47yjWJR%2BMy80PfbyEIBHN5FIeNlD4TNKZEDtMgxjNJPJfBP1KitURdmWLVusiYkJSIyXMsZOlVJ6Dr8SxIs%2FZbLZbHLlypWIESy78G95CDT2qHlPgD4JvoFz%2FlAu%2B%2B0tZRQBQFT6rznnt2Wz2UcrKRYZTB124Uwm8xbbti%2FmnH8AfUdmui9yfqWUqwcGBjY2dgnou8UQAbSY%2FX4uVu4DQYm0UMyiN9zoJg5jHrQOP6h6O0JTciaX3eHN2teIIB0epZQ62jTN03Npmb1%2BGmq5lZv32LZ9xdlnn%2F1ADHGreEgtQYBAZdOmTejBioDigg2TCiA3kc1mnzZNMyWEeBgVmQ8ePDh5%2BOGHo70gYpuCD5wm8BR3WJZ1mG3bb2OMnSuEQPbGtL4J4YUb2d0nhBCX9%2FT0PFDhDl7xhOsTmgMBv6ERnGWoADOtxzWeYAYpDYHF%2BJmQUk4KIdJtbW2IOOhSSsH%2BjDTOw5BvX0KyLHQPhOJcmYv1%2B3Ej8nQbMVMtQ4AAc926dW9PJBI%2F9e15laSFwVv8HGMM0eu7hBCoWDElpUy0t7d3OY4DozWi5BHH5Xl3K1hYqPt2tW3b98yXRdWIhdsK9%2FArCl2nlEKAsxeOVcG68iAqRZSVXA%2FhLoSQy7q7uzfOp026pQgQE%2B5XqkYpKzg28oskmgoVDU0JLyb%2FWM%2F2EU5ji4bZhK8RVmFC99oppbxm4cKFa%2BbTomoFcmrUM%2FqBzjCjXBsuRFBCm6hpwQg%2FVOZhv4oSHB5NbfOLzlvLESAAQBEC9A%2BhlPb6OZENbcCNRaSUQgbKxejepcmvUXTStPeBTfAE9JomhGDj9mzKlW64hTbhUt9BjUaVFiHErbPpTRJn1FuSADEh%2Fs76CcTcQSUukGBfUc28SGpQKUKFynufaZo3FarlFufFosc2twj4pa5WoCIRHHpIZyuWOheWECOB1DM6O3JZShN%2BsdXbmj3MZaYZa1kCBDDwir3yyivHGYaBKhpodbk4DFi5paNmAtlfjEhofxJZIFLKn9ejwUs549DHND0CbMOGDUe4rturlDrfMAw422B3LlZRqFyVGI495A8%2FalnWvZOTk9ubOcC53FluaQIMQELYyp49e061LAuVl%2FujPUvKBbPQcQiyJoQ8ads2GlFvnIuaZ7MZvz43vgigzuRb3%2FpWlEk7XQiBFDqUtJ9WM7IM6Q%2FSHrq%2BoW8IegQ3dWBzpbOlCTCEmF%2F49GhUkVFK9eXsH29AU%2FRiZYCihuiQGoy6Zztt20Yjmgez2ezjrbCbVrr49PG1QQCazMsvv9xmmuZhpmmeTAj5ayklYl8PE0K0IS2OUgqbIaIZkPOOPpqeJD4AAAKhSURBVB%2B%2Fz0mR25VSTy9atAgZIQUbfNVmhPG9iibAInOD9DW%2FX8kJhmH8rRDiWL9fCcIRwjmS8Ioh93enHybzBBZWLpfyhcHBQZQ9n1des%2FguZT2yKALY0Pft29dmGIYnFaIWX1zq8MVltjQBVjAT2Gn37duXL8dPKbUNw5icmpqa0DF8FQCpD9UIxAQBTYAxmQg9DI2ARqDxCGgCbDzm%2Bo4aAY1ATBDQBBiTidDD0AhoBBqPgCbAxmOu76gR0AjEBAFNgDGZCD0MjYBGoPEIaAJsPOb6jhoBjUBMENAEGJOJ0MPQCGgEGo%2BAJsDGY67vqBHQCMQEAU2AMZkIPQyNgEag8QhoAmw85vqOGgGNQEwQ0AQYk4nQw9AIaAQaj4AmwMZjru%2BoEdAIxAQBTYAxmQg9DI2ARqDxCGgCbDzm%2Bo4aAY1ATBDQBBiTidDD0AhoBBqPgCbAxmOu76gR0AjEBAFNgDGZCD0MjYBGoPEIaAJsPOb6jhoBjUBMENAEGJOJ0MPQCGgEGo%2BAJsDGY67vqBHQCMQEAU2AMZkIPQyNgEag8QhoAmw85vqOGgGNQEwQ0AQYk4nQw9AIaAQaj4AmwMZjru%2BoEdAIxAQBTYAxmQg9DI2ARqDxCGgCbDzm%2Bo4aAY1ATBDQBBiTidDD0AhoBBqPgCbAxmOu76gR0AjEBAFNgDGZCD0MjYBGoPEIaAJsPOb6jhoBjUBMENAEGJOJ0MPQCGgEGo%2BAJsDGY67vqBHQCMQEAU2AMZkIPQyNgEag8QhoAmw85vqOGgGNQEwQ0AQYk4nQw9AIaAQaj4AmwMZjru%2BoEdAIxAQBTYAxmQg9DI2ARqDxCGgCbDzm%2Bo4aAY1ATBDQBBiTidDD0AhoBBqPgCbAxmOu76gR0AjEBIH%2FD0MjQI9zMA1pAAAAAElFTkSuQmCC;base64,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" height="191" width="320" id="image0_782_249"/>
					
				<title>Layer 1</title>
				<rect x="0" y="-1" id="svg_2" fill="white" height="205" width="386"/>
				<rect id="svg_3" fill="url(#pattern0_782_249)" height="191" width="320" x="33"/>
				<line id="svg_4" stroke="#B9B4B4" y2="173.5" x2="325.014" y1="173.5" x1="51.9844"/>
				<line id="svg_5" stroke="#B9B4B4" y2="90.003" x2="32.5" y1="170.518" x1="32.9883"/>
				<text transform="matrix(0.9057243104757049,0,0,0.9248965636995193,30.402212034205967,14.566524952852195) " xml:space="preserve" text-anchor="middle" font-family="serif" font-size="24" id="svg_8" y="178.177251" x="349" stroke-linecap="null" stroke-linejoin="null" stroke-dasharray="null" stroke-width="0" fill="#7f7f7f"><?php echo $data_model['specifications'][$key_complect]['length']; ?></text>
				<text style="cursor: move;" id="svg_9" transform="rotate(-90.00001525878906 33.00038146972656,56.499481201171875) matrix(0.9057243104757048,0,0,0.9248965636995193,200.89061535451847,77.28259703537172) " xml:space="preserve" text-anchor="middle" font-family="serif" font-size="24" y="-14.276703" x="-185.378943" stroke-linecap="null" stroke-linejoin="null" stroke-dasharray="null" stroke-width="0" fill="#7f7f7f">2000</text>
				</g>
				</svg>
			<div class="complect__main-inf">
				<div class="complect__main-inf-col">
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Объем" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['volume-litres']); ?> <?php echo $ULang->t( "л" ); ?></strong>
					</div>
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Мощность" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['horse-power']); ?></strong>
					</div>
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Коробка" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['transmission']); ?></strong>
					</div>
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Тип двигателя" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['engine-type']); ?></strong>							
					</div>
				</div>
				<div class="complect__main-inf-col">
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Топливо" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['petrol-type']); ?></strong>
					</div>
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Привод" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['drive']); ?></strong>
					</div>
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Разгон" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['time-to-100']); ?></strong>
					</div>
					<div class="complect__main-inf-block">
						<span><?php echo $ULang->t( "Расход" ); ?></span>
						<strong><?php echo $ULang->t($data_model['specifications'][$key_complect]['consumption-mixed']); ?> <?php echo $ULang->t( "л" ); ?></strong>
					</div>
				</div>
			</div>
		</div>

		<div class="complect_box">
			<div class="complect__inf-box">
				
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Общая информация" ); ?></span>
					<div class="complect__inf-body">
						

							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Страна марки" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $ULang->t($data_model['mark']['country']); ?>
								</div>
							</div>

								<div class="complect__inf-block">
									<div class="complect__inf-block-title">
										<?php echo $ULang->t( "Класс" ); ?>
									</div>
									<div class="complect__inf-block-data">
										<?php echo $ULang->t($data_model['class']); ?>
									</div>
								</div>
									<div class="complect__inf-block">
										<div class="complect__inf-block-title">
											<?php echo $ULang->t( "Количество дверей" ); ?>
										</div>
										<div class="complect__inf-block-data">
											<?php echo $ULang->t($data_model['configuration'][0][0]['doors-count']); ?>
										</div>
									</div>
									
									<?php if($data_model['specifications'][$key_complect]['seats']){?>
										<div class="complect__inf-block">
											<div class="complect__inf-block-title">
												<?php echo $ULang->t( "Количество мест" ); ?>
											</div>
											<div class="complect__inf-block-data">
												<?php echo $ULang->t($data_model['specifications'][$key_complect]['seats']); ?>
											</div>
										</div>
										<?php }?>
					</div>
				</div>
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Размеры" ); ?></span>
					<div class="complect__inf-body">
						<?php if($data_model['specifications'][$key_complect]['length']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Длина" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $data_model['specifications'][$key_complect]['length']; ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['width']){?>
								<div class="complect__inf-block">
									<div class="complect__inf-block-title">
										<?php echo $ULang->t( "Ширина" ); ?>
									</div>
									<div class="complect__inf-block-data">
										<?php echo $data_model['specifications'][$key_complect]['width']; ?>
									</div>
								</div>
								<?php }?>
								<?php if($data_model['specifications'][$key_complect]['height']){?>
									<div class="complect__inf-block">
										<div class="complect__inf-block-title">
											<?php echo $ULang->t( "Высота" ); ?>
										</div>
										<div class="complect__inf-block-data">
											<?php echo $data_model['specifications'][$key_complect]['height']; ?>
										</div>
									</div>
									<?php }?>
									<?php if($data_model['specifications'][$key_complect]['wheel-base']){?>
										<div class="complect__inf-block">
											<div class="complect__inf-block-title">
												<?php echo $ULang->t( "Колёсная база" ); ?>
											</div>
											<div class="complect__inf-block-data">
												<?php echo $data_model['specifications'][$key_complect]['wheel-base']; ?>
											</div>
										</div>
										<?php }?>
										<?php if($data_model['specifications'][$key_complect]['front-wheel-base']){?>
											<div class="complect__inf-block">
												<div class="complect__inf-block-title">
													<?php echo $ULang->t( "Ширина передней колеи" ); ?>
												</div>
												<div class="complect__inf-block-data">
													<?php echo $data_model['specifications'][$key_complect]['front-wheel-base']; ?>
												</div>
											</div>
											<?php }?>
											<?php if($data_model['specifications'][$key_complect]['back-wheel-base']){?>
												<div class="complect__inf-block">
													<div class="complect__inf-block-title">
														<?php echo $ULang->t( "Ширина задней колеи" ); ?>
													</div>
													<div class="complect__inf-block-data">
														<?php echo $data_model['specifications'][$key_complect]['back-wheel-base']; ?>
													</div>
												</div>
												<?php }?>
												<?php if($data_model['specifications'][$key_complect]['wheel-size']){?>
													<div class="complect__inf-block">
														<div class="complect__inf-block-title">
															<?php echo $ULang->t( "Размер колёс" ); ?>
														</div>
														<div class="complect__inf-block-data">
															<?php echo $data_model['specifications'][$key_complect]['wheel-size']; ?>
														</div>
													</div>
													<?php }?>
					</div>
				</div>
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Объём и масса" ); ?></span>
					<div class="complect__inf-body">
						<?php if($data_model['specifications'][$key_complect]['trunks-max-capacity']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Объем багажника" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $data_model['specifications'][$key_complect]['trunks-max-capacity']; ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['fuel-tank-capacity']){?>
								<div class="complect__inf-block">
									<div class="complect__inf-block-title">
										<?php echo $ULang->t( "Объём топливного бака" ); ?>
									</div>
									<div class="complect__inf-block-data">
										<?php echo $data_model['specifications'][$key_complect]['fuel-tank-capacity']; ?>
									</div>
								</div>
								<?php }?>
								<?php if($data_model['specifications'][$key_complect]['weight']){?>
									<div class="complect__inf-block">
										<div class="complect__inf-block-title">
											<?php echo $ULang->t( "Снаряженная масса" ); ?>
										</div>
										<div class="complect__inf-block-data">
											<?php echo $data_model['specifications'][$key_complect]['weight']; ?>
										</div>
									</div>
									<?php }?>
									<?php if($data_model['specifications'][$key_complect]['full-weight']){?>
										<div class="complect__inf-block">
											<div class="complect__inf-block-title">
												<?php echo $ULang->t( "Полная масса" ); ?>
											</div>
											<div class="complect__inf-block-data">
												<?php echo $data_model['specifications'][$key_complect]['full-weight']; ?>
											</div>
										</div>
										<?php }?>
					</div>
				</div>
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Трансмиссия" ); ?></span>
					<div class="complect__inf-body">
						<?php if($data_model['specifications'][$key_complect]['drive']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Тип привода" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $ULang->t($data_model['specifications'][$key_complect]['drive']); ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['transmission']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Коробка передач" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $ULang->t($data_model['specifications'][$key_complect]['transmission']); ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['gear-value']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Количество передач" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $data_model['specifications'][$key_complect]['gear-value']; ?>
								</div>
							</div>
							<?php }?>
					</div>
				</div>
			</div>

			<div class="complect__inf-box">
				
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Подвезка и тормоза" ); ?></span>
					<div class="complect__inf-body">
						<?php if($data_model['specifications'][$key_complect]['front-suspension']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Тип передней подвески" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $ULang->t($data_model['specifications'][$key_complect]['front-suspension']); ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['back-suspension']){?>
								<div class="complect__inf-block">
									<div class="complect__inf-block-title">
										<?php echo $ULang->t( "Тип задней подвески" ); ?>
									</div>
									<div class="complect__inf-block-data">
										<?php echo $ULang->t($data_model['specifications'][$key_complect]['back-suspension']); ?>
									</div>
								</div>
								<?php }?>
								<?php if($data_model['specifications'][$key_complect]['front-brake']){?>
									<div class="complect__inf-block">
										<div class="complect__inf-block-title">
											<?php echo $ULang->t( "Передние тормоза" ); ?>
										</div>
										<div class="complect__inf-block-data">
											<?php echo $ULang->t($data_model['specifications'][$key_complect]['front-brake']); ?>
										</div>
									</div>
									<?php }?>
									<?php if($data_model['specifications'][$key_complect]['back-brake']){?>
										<div class="complect__inf-block">
											<div class="complect__inf-block-title">
												<?php echo $ULang->t( "Задние тормоза" ); ?>
											</div>
											<div class="complect__inf-block-data">
												<?php echo $ULang->t($data_model['specifications'][$key_complect]['back-brake']); ?>
											</div>
										</div>
										<?php }?>
					</div>
				</div>
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Эксплутационные показатели" ); ?></span>
					<div class="complect__inf-body">
						<?php if($data_model['specifications'][$key_complect]['max-speed']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Максимальная скорость" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $ULang->t($data_model['specifications'][$key_complect]['max-speed']); ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['time-to-100']){?>
								<div class="complect__inf-block">
									<div class="complect__inf-block-title">
										<?php echo $ULang->t( "Разгон до 100 км/ч" ); ?>
									</div>
									<div class="complect__inf-block-data">
										<?php echo $ULang->t($data_model['specifications'][$key_complect]['time-to-100']); ?>
									</div>
								</div>
								<?php }?>
									<?php if($data_model['specifications'][$key_complect]['petrol-type']){?>
										<div class="complect__inf-block">
											<div class="complect__inf-block-title">
												<?php echo $ULang->t( "Марка топлива" ); ?>
											</div>
											<div class="complect__inf-block-data">
												<?php echo $ULang->t($data_model['specifications'][$key_complect]['petrol-type']); ?>
											</div>
										</div>
										<?php }?>
										<?php if($data_model['specifications'][$key_complect]['emission-euro-class']){?>
											<div class="complect__inf-block">
												<div class="complect__inf-block-title">
													<?php echo $ULang->t( "	Экологический класс" ); ?>
												</div>
												<div class="complect__inf-block-data">
													<?php echo $ULang->t($data_model['specifications'][$key_complect]['emission-euro-class']); ?>
												</div>
											</div>
											<?php }?>
					</div>
				</div>
				
				<div class="complect__inf">
					<span class="complect__inf-title"><?php echo $ULang->t( "Двигатель" ); ?></span>
					<div class="complect__inf-body">
						<?php if($data_model['specifications'][$key_complect]['engine-type']){?>
							<div class="complect__inf-block">
								<div class="complect__inf-block-title">
									<?php echo $ULang->t( "Тип двигателя" ); ?>
								</div>
								<div class="complect__inf-block-data">
									<?php echo $ULang->t($data_model['specifications'][$key_complect]['engine-type']); ?>
								</div>
							</div>
							<?php }?>
							<?php if($data_model['specifications'][$key_complect]['engine-order']){?>
								<div class="complect__inf-block">
									<div class="complect__inf-block-title">
										<?php echo $ULang->t( "Расположение двигателя" ); ?>
									</div>
									<div class="complect__inf-block-data">
										<?php echo $ULang->t($data_model['specifications'][$key_complect]['engine-order']); ?>
									</div>
								</div>
								<?php }?>
								<?php if($data_model['specifications'][$key_complect]['volume-litres']){?>
									<div class="complect__inf-block">
										<div class="complect__inf-block-title">
											<?php echo $ULang->t( "Объем двигателя" ); ?>
										</div>
										<div class="complect__inf-block-data">
											<?php echo $ULang->t($data_model['specifications'][$key_complect]['volume-litres']); ?>
										</div>
									</div>
									<?php }?>
									<?php if($data_model['specifications'][$key_complect]['feeding']){?>
										<div class="complect__inf-block">
											<div class="complect__inf-block-title">
												<?php echo $ULang->t( "Тип наддува" ); ?>
											</div>
											<div class="complect__inf-block-data">
												<?php echo $ULang->t($data_model['specifications'][$key_complect]['feeding']); ?>
											</div>
										</div>
										<?php }?>
										<?php if($data_model['specifications'][$key_complect]['horse-power']){?>
											<div class="complect__inf-block">
												<div class="complect__inf-block-title">
													<?php echo $ULang->t( "Мощность" ); ?>
												</div>
												<div class="complect__inf-block-data">
													<?php echo $ULang->t($data_model['specifications'][$key_complect]['horse-power']); ?>
												</div>
											</div>
											<?php }?>
											<?php if($data_model['specifications'][$key_complect]['cylinders-order']){?>
												<div class="complect__inf-block">
													<div class="complect__inf-block-title">
														<?php echo $ULang->t( "Расположение цилиндров" ); ?>
													</div>
													<div class="complect__inf-block-data">
														<?php echo $ULang->t($data_model['specifications'][$key_complect]['cylinders-order']); ?>
													</div>
												</div>
												<?php }?>
												<?php if($data_model['specifications'][$key_complect]['cylinders-value']){?>
													<div class="complect__inf-block">
														<div class="complect__inf-block-title">
															<?php echo $ULang->t( "Количество цилиндров" ); ?>
														</div>
														<div class="complect__inf-block-data">
															<?php echo $ULang->t($data_model['specifications'][$key_complect]['cylinders-value']); ?>
														</div>
													</div>
													<?php }?>
													<?php if($data_model['specifications'][$key_complect]['engine-feeding']){?>
														<div class="complect__inf-block">
															<div class="complect__inf-block-title">
																<?php echo $ULang->t( "Система питания двигателя" ); ?>
															</div>
															<div class="complect__inf-block-data">
																<?php echo $ULang->t($data_model['specifications'][$key_complect]['engine-feeding']); ?>
															</div>
														</div>
														<?php }?>
														<?php if($data_model['specifications'][$key_complect]['diametr']){?>
															<div class="complect__inf-block">
																<div class="complect__inf-block-title">
																	<?php echo $ULang->t( "Диаметр цилиндра" ); ?>
																</div>
																<div class="complect__inf-block-data">
																	<?php echo $ULang->t($data_model['specifications'][$key_complect]['diametr']); ?>
																</div>
															</div>
															<?php }?>
					</div>
				</div>
			</div>
			
		</div>
	</div>

	<div class="col-lg-2">
		<?php echo $Banners->out( ["position_name"=>"catalog_base_sidebar"] ); ?>
	</div>

</div>
		<?php echo $Banners->out( ["position_name"=>"catalog_base_bottom"] ); ?>
		<?php }?>
	</div>
	<?php } ?>
	

	
	<?php include $config["template_path"] . "/footer.tpl"; ?>
</body>

<script>

	document.querySelectorAll('#complectation').forEach((el, index) => {
		if (el) {
			el.addEventListener('click', () => {
				window.location = window.location.href + '/' + el.getAttribute('data-complect')
			})
		}
	})

	document.querySelectorAll('.complect_name').forEach((el, index) => {
		if (el.classList.contains('active')) {
			setTimeout(() => {
				el.scrollIntoView({ behavior: "smooth" })
			}, 500)
		}
	})

	if(document.querySelector('.filter_base-mob')) {
		document.querySelector('.filter_base-mob').addEventListener('click',() => {
			document.querySelector('.filters_base').classList.add('active')
		})

		document.querySelector('.filter_base-mob-close').addEventListener('click',() => {
			document.querySelector('.filters_base').classList.remove('active')
		})
	}

	// document.querySelectorAll('.complect-switch_block').forEach((el, index) => {
	// 	if (el) {
	// 		el.addEventListener('click', () => {
	// 			document.querySelectorAll('.complect-switch_block').forEach((el, index) => {
	// 				el.classList.remove('active')
	// 				document.querySelectorAll('.complect_name-child-inf')[index].classList.remove('active')
	// 			})
	// 			el.classList.add('active')
	// 			document.querySelectorAll('.complect_name-child-inf')[index].classList.add('active')
	// 		})
	// 	}
	// })


	document.querySelectorAll('.complect_name-child-inf-block').forEach(el => {
		if (el.querySelectorAll('.complect_name-child-inf-block-list ul li').length == 0) {
			el.style.display = "none"
		}
	})

	document.querySelectorAll('#page_nav').forEach(el => {
		el.addEventListener('click',(e) => {
			e.preventDefault();
			window.location = window.location.href+<?php if(!count($_GET)){ echo ('"?" +') ;}?>'&page='+el.getAttribute('data-page')
			
		})
	})

	

	

</script>

</html>