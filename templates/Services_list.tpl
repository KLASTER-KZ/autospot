<form method="post" class="form-ads-services" >
						
    <div class="row no-gutters gutters10" style="justify-content: center; align-items: start; gap: 70px;">							

        <?php
                $getServices = getAll("SELECT * FROM uni_services_ads order by services_ads_id_position asc");
                                
                if(count($getServices)){
                    foreach ($getServices as $value) {
                        if($value['services_ads_visible'] == 1){
                    ?>	

                    <?php include $config["template_path"] . "/include/services_tariffs.php"; ?>

        <?php 
                        }
                    }
                }
        ?>

        
        
    </div>
    
    <input type="hidden" name="id_s" value="3">
    <input type="hidden" name="id_ad" value="<?php echo $data["ad"]["ads_id"]; ?>" >
                            
    
</form>