<meta name="csrf-token" content="<?php echo csrf_token(); ?>">

<?php /*
 <!-- Google Tag Manager -->
<script>

    </script>
<!-- End Google Tag Manager -->
 */ ?>
<?php
echo preg_replace("/\/>/",">",$settings["header_meta"]);
?>

<!-- 18-08-2023 Correction 42 Fonts transfered on server
//<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600&display=swap" rel="stylesheet">
//<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;700&family=Roboto:wght@100;300&display=swap" rel="stylesheet">
-->
<link rel="preconnect" href="https://autospot.ge/">
<link rel="dns-prefetch" href="https://autospot.ge/">
<link rel="icon" href="https://autospot.ge/favicon.ico" type="image/x-icon">
<!-- Updated Correction of meta tags -->
 <?php
echo $Main->assets($config["css_styles"], 'css');
echo $Main->outFavicon(); 
?>