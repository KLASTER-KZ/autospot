-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 18 2022 г., 22:39
-- Версия сервера: 5.7.38-0ubuntu0.18.04.1
-- Версия PHP: 7.3.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `testing`
--

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters`
--

CREATE TABLE `uni_ads_filters` (
  `ads_filters_id` int(11) NOT NULL,
  `ads_filters_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_visible` int(1) NOT NULL DEFAULT '1',
  `ads_filters_type` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ads_filters_position` int(11) NOT NULL DEFAULT '0',
  `ads_filters_podcat` int(1) NOT NULL DEFAULT '1',
  `ads_filters_id_parent` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_required` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_ads_filters`
--

INSERT INTO `uni_ads_filters` (`ads_filters_id`, `ads_filters_name`, `ads_filters_visible`, `ads_filters_type`, `ads_filters_position`, `ads_filters_podcat`, `ads_filters_id_parent`, `ads_filters_alias`, `ads_filters_required`) VALUES
(116, 'Марка', 1, 'select', 108, 1, 0, 'marka', 1),
(117, 'Группа', 1, 'select', 109, 1, 0, 'gruppa', 1),
(118, 'Крепление', 1, 'select', 110, 1, 0, 'kreplenie', 0),
(119, 'Тип', 1, 'select', 111, 1, 0, 'tip', 1),
(120, 'Тип', 1, 'select', 112, 1, 0, 'tip', 1),
(121, 'Марка', 1, 'select', 113, 1, 0, 'marka', 1),
(122, 'Тип', 1, 'select', 114, 1, 0, 'tip', 1),
(123, 'Возраст', 1, 'select', 115, 1, 0, 'vozrast', 1),
(124, 'Количество блоков', 1, 'select', 116, 1, 0, 'kolichestvo-blokov', 0),
(125, 'Тип колес', 1, 'select', 117, 1, 0, 'tip-koles', 0),
(126, 'Особенности', 1, 'select', 118, 1, 0, 'osobennosti', 0),
(127, 'Регулировки', 1, 'select', 119, 1, 0, 'regulirovki', 0),
(128, 'Тип', 1, 'select', 120, 1, 0, 'tip', 1),
(129, 'Тип', 1, 'select', 121, 1, 0, 'tip', 1),
(130, 'Тип', 1, 'select', 122, 1, 0, 'tip', 1),
(131, 'Тип', 1, 'select', 123, 1, 0, 'tip', 1),
(132, 'Тип', 1, 'select', 124, 1, 0, 'tip', 1),
(133, 'Тип', 1, 'select', 125, 1, 0, 'tip', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_alias`
--

CREATE TABLE `uni_ads_filters_alias` (
  `ads_filters_alias_id` int(11) NOT NULL,
  `ads_filters_alias_id_filter_item` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias_title` varchar(255) DEFAULT NULL,
  `ads_filters_alias_alias` varchar(255) DEFAULT NULL,
  `ads_filters_alias_id_cat` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias_desc` text,
  `ads_filters_alias_h1` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_category`
--

CREATE TABLE `uni_ads_filters_category` (
  `ads_filters_category_id` int(11) NOT NULL,
  `ads_filters_category_id_cat` int(11) NOT NULL DEFAULT '0',
  `ads_filters_category_id_filter` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_ads_filters_category`
--

INSERT INTO `uni_ads_filters_category` (`ads_filters_category_id`, `ads_filters_category_id_cat`, `ads_filters_category_id_filter`) VALUES
(779, 186, 116),
(780, 186, 117),
(781, 186, 118),
(782, 187, 119),
(783, 188, 120),
(784, 189, 121),
(785, 189, 122),
(786, 189, 123),
(787, 189, 124),
(788, 189, 125),
(789, 189, 126),
(790, 189, 127),
(791, 190, 128),
(792, 191, 129),
(793, 192, 130),
(794, 193, 131),
(795, 195, 132),
(796, 196, 133);

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_items`
--

CREATE TABLE `uni_ads_filters_items` (
  `ads_filters_items_id` int(11) NOT NULL,
  `ads_filters_items_id_filter` int(11) NOT NULL DEFAULT '0',
  `ads_filters_items_value` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_items_id_item_parent` int(11) NOT NULL DEFAULT '0',
  `ads_filters_items_alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_items_sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_ads_filters_items`
--

INSERT INTO `uni_ads_filters_items` (`ads_filters_items_id`, `ads_filters_items_id_filter`, `ads_filters_items_value`, `ads_filters_items_id_item_parent`, `ads_filters_items_alias`, `ads_filters_items_sort`) VALUES
(1143, 116, 'BRITAX RÖMER', 0, 'britax-roemer', 0),
(1144, 116, 'Baby Care', 0, 'baby-care', 0),
(1145, 116, 'Bebe confort', 0, 'bebe-confort', 0),
(1146, 116, 'Bertoni Lorelli', 0, 'bertoni-lorelli', 0),
(1147, 116, 'Carmate', 0, 'carmate', 0),
(1148, 116, 'Chicco', 0, 'chicco', 0),
(1149, 116, 'Coto Baby', 0, 'coto-baby', 0),
(1150, 116, 'Cybex', 0, 'cybex', 0),
(1151, 116, 'Graco', 0, 'graco', 0),
(1152, 116, 'Happy Baby', 0, 'happy-baby', 0),
(1153, 116, 'Inglesina', 0, 'inglesina', 0),
(1154, 116, 'Kenga', 0, 'kenga', 0),
(1155, 116, 'Lider Kids', 0, 'lider-kids', 0),
(1156, 116, 'Maxi-Cosi', 0, 'maxi-cosi', 0),
(1157, 116, 'Nania', 0, 'nania', 0),
(1158, 116, 'Peg-Perego', 0, 'peg-perego', 0),
(1159, 116, 'Recaro', 0, 'recaro', 0),
(1160, 116, 'Siger', 0, 'siger', 0),
(1161, 116, 'Рант', 0, 'rant', 0),
(1162, 116, 'Мишутка', 0, 'mishutka', 0),
(1163, 117, '0 (до 10 кг)', 0, '0-do-10-kg', 0),
(1164, 117, '0+ (до 13 кг)', 0, '0-do-13-kg', 0),
(1165, 117, '0/1 (до 18 кг)', 0, '0-1-do-18-kg', 0),
(1166, 117, '0/1/2 (до 25 кг)', 0, '0-1-2-do-25-kg', 0),
(1167, 117, '0/1/2/3 (до 36 кг)', 0, '0-1-2-3-do-36-kg', 0),
(1168, 117, '1 (9-18 кг)', 0, '1-9-18-kg', 0),
(1169, 117, '1/2 (9-25 кг)', 0, '1-2-9-25-kg', 0),
(1170, 117, '1/2/3 (9-36 кг)', 0, '1-2-3-9-36-kg', 0),
(1171, 117, '2/3 (15-36 кг)', 0, '2-3-15-36-kg', 0),
(1172, 117, '3 (22-26 кг)', 0, '3-22-26-kg', 0),
(1173, 118, 'Isofix', 0, 'isofix', 0),
(1174, 118, 'Latch', 0, 'latch', 0),
(1175, 118, 'Автомобильные ремни', 0, 'avtomobilnye-remni', 0),
(1176, 119, 'Гигиена полости рта', 0, 'gigiena-polosti-rta', 0),
(1177, 119, 'Детские весы', 0, 'detskie-vesy', 0),
(1178, 119, 'Кремы, присыпки', 0, 'kremy-prisypki', 0),
(1179, 119, 'Назальные аспираторы', 0, 'nazalnye-aspiratory', 0),
(1180, 119, 'Прорезыватели', 0, 'prorezyvateli', 0),
(1181, 119, 'Термометры', 0, 'termometry', 0),
(1182, 120, 'Воздушные змеи', 0, 'vozdushnye-zmei', 0),
(1183, 120, 'Детские бассейны', 0, 'detskie-basseyny', 0),
(1184, 120, 'Детские батуты', 0, 'detskie-batuty', 0),
(1185, 120, 'Железные дороги', 0, 'zheleznye-dorogi', 0),
(1186, 120, 'Играем в профессии', 0, 'igraem-v-professii', 0),
(1187, 120, 'Игровые домики, палатки', 0, 'igrovye-domiki-palatki', 0),
(1188, 120, 'Игровые комплексы, горки', 0, 'igrovye-kompleksy-gorki', 0),
(1189, 120, 'Игрушечное оружие', 0, 'igrushechnoe-oruzhie', 0),
(1190, 120, 'Игрушки для ванной', 0, 'igrushki-dlya-vannoy', 0),
(1191, 120, 'Каталки, качалки', 0, 'katalki-kachalki', 0),
(1192, 120, 'Квадрокоптеры', 0, 'kvadrokoptery', 0),
(1193, 120, 'Конструкторы', 0, 'konstruktory', 0),
(1194, 120, 'Куклы', 0, 'kukly', 0),
(1195, 120, 'Машинки, техника', 0, 'mashinki-tehnika', 0),
(1196, 120, 'Мобили в кроватку', 0, 'mobili-v-krovatku', 0),
(1197, 120, 'Музыкальные игрушки', 0, 'muzykalnye-igrushki', 0),
(1198, 120, 'Мыльные пузыри', 0, 'mylnye-puzyri', 0),
(1199, 120, 'Мягкие игрушки', 0, 'myagkie-igrushki', 0),
(1200, 120, 'Напольные коврики', 0, 'napolnye-kovriki', 0),
(1201, 120, 'Обучающие игрушки', 0, 'obuchayushchie-igrushki', 0),
(1202, 120, 'Пазлы', 0, 'pazly', 0),
(1203, 120, 'Песочницы и игрушки', 0, 'pesochnicy-i-igrushki', 0),
(1204, 120, 'Погремушки', 0, 'pogremushki', 0),
(1205, 120, 'Роботы', 0, 'roboty', 0),
(1206, 120, 'Сборные модели', 0, 'sbornye-modeli', 0),
(1207, 120, 'Фигурки, солдатики', 0, 'figurki-soldatiki', 0),
(1208, 120, 'Электромобили', 0, 'elektromobili', 0),
(1209, 121, 'Adamex', 0, 'adamex', 0),
(1210, 121, 'Anex', 0, 'anex', 0),
(1211, 121, 'Aprica', 0, 'aprica', 0),
(1212, 121, 'Baby Care', 0, 'baby-care', 0),
(1213, 121, 'Baby Design', 0, 'baby-design', 0),
(1214, 121, 'Baby-Merc', 0, 'baby-merc', 0),
(1215, 121, 'Babyhit', 0, 'babyhit', 0),
(1216, 121, 'BeBe-Mobile', 0, 'bebe-mobile', 0),
(1217, 121, 'Bebbetto', 0, 'bebbetto', 0),
(1218, 121, 'Bertoni Lorelli', 0, 'bertoni-lorelli', 0),
(1219, 121, 'CAM', 0, 'cam', 0),
(1220, 121, 'Camarelo', 0, 'camarelo', 0),
(1221, 121, 'Capella', 0, 'capella', 0),
(1222, 121, 'Chicco', 0, 'chicco', 0),
(1223, 121, 'Cosatto', 0, 'cosatto', 0),
(1224, 121, 'Emmaljunga', 0, 'emmaljunga', 0),
(1225, 121, 'Esspero', 0, 'esspero', 0),
(1226, 121, 'FD Design', 0, 'fd-design', 0),
(1227, 121, 'Foppapedretti', 0, 'foppapedretti', 0),
(1228, 121, 'Geoby', 0, 'geoby', 0),
(1229, 121, 'Happy Baby', 0, 'happy-baby', 0),
(1230, 121, 'Hauck', 0, 'hauck', 0),
(1231, 121, 'Indigo', 0, 'indigo', 0),
(1232, 121, 'Inglesina', 0, 'inglesina', 0),
(1233, 121, 'Jane', 0, 'jane', 0),
(1234, 121, 'Jedo', 0, 'jedo', 0),
(1235, 121, 'Jetem', 0, 'jetem', 0),
(1236, 121, 'Lonex', 0, 'lonex', 0),
(1237, 121, 'Maclaren', 0, 'maclaren', 0),
(1238, 121, 'Marimex', 0, 'marimex', 0),
(1239, 121, 'Maxima', 0, 'maxima', 0),
(1240, 121, 'Navington', 0, 'navington', 0),
(1241, 121, 'Noordline', 0, 'noordline', 0),
(1242, 121, 'Peg-perego', 0, 'peg-perego', 0),
(1243, 121, 'Phil&amp;Teds', 0, 'phil-teds', 0),
(1244, 121, 'ROAN', 0, 'roan', 0),
(1245, 121, 'Reindeer', 0, 'reindeer', 0),
(1246, 121, 'Riko', 0, 'riko', 0),
(1247, 121, 'Silver Cross', 0, 'silver-cross', 0),
(1248, 121, 'Slaro', 0, 'slaro', 0),
(1249, 121, 'Teutonia', 0, 'teutonia', 0),
(1250, 121, 'Tutek', 0, 'tutek', 0),
(1251, 121, 'Tutic', 0, 'tutic', 0),
(1252, 121, 'Tutis', 0, 'tutis', 0),
(1253, 121, 'Мишутка', 0, 'mishutka', 0),
(1254, 122, 'Люлька', 0, 'lyulka', 0),
(1255, 122, 'Прогулочная', 0, 'progulochnaya', 0),
(1256, 122, 'Трансформер', 0, 'transformer', 0),
(1257, 122, 'Универсальная', 0, 'universalnaya', 0),
(1258, 123, 'До 1 года', 0, 'do-1-goda', 0),
(1259, 123, 'До 2 лет', 0, 'do-2-let', 0),
(1260, 123, 'До 3 лет', 0, 'do-3-let', 0),
(1261, 123, 'До 4 лет', 0, 'do-4-let', 0),
(1262, 123, 'До 5 лет', 0, 'do-5-let', 0),
(1263, 124, 'Для одного', 0, 'dlya-odnogo', 0),
(1264, 124, 'Для двойни', 0, 'dlya-dvoyni', 0),
(1265, 124, 'Для тройни', 0, 'dlya-troyni', 0),
(1266, 124, 'Для погодок', 0, 'dlya-pogodok', 0),
(1267, 125, 'Пневматические', 0, 'pnevmaticheskie', 0),
(1268, 125, 'Пластиковые', 0, 'plastikovye', 0),
(1269, 125, 'Гелевые', 0, 'gelevye', 0),
(1270, 125, 'Резиновые', 0, 'rezinovye', 0),
(1271, 126, 'Сумка', 0, 'sumka', 0),
(1272, 126, 'Дождевик', 0, 'dozhdevik', 0),
(1273, 126, 'Матрас', 0, 'matras', 0),
(1274, 126, 'Корзина для покупок', 0, 'korzina-dlya-pokupok', 0),
(1275, 126, 'Конверт', 0, 'konvert', 0),
(1276, 126, 'Муфта', 0, 'mufta', 0),
(1277, 126, 'Москитная сетка', 0, 'moskitnaya-setka', 0),
(1278, 126, 'Чехол на ноги', 0, 'chehol-na-nogi', 0),
(1279, 126, 'Ремни', 0, 'remni', 0),
(1280, 126, 'Бампер', 0, 'bamper', 0),
(1281, 126, 'Козырек от солнца', 0, 'kozyrek-ot-solnca', 0),
(1282, 126, 'Для бега', 0, 'dlya-bega', 0),
(1283, 127, 'Ручка', 0, 'ruchka', 0),
(1284, 127, 'Наклон спинки', 0, 'naklon-spinki', 0),
(1285, 127, 'Фиксация колёс', 0, 'fiksaciya-koles', 0),
(1286, 128, 'Бутылочки, ниблеры', 0, 'butylochki-niblery', 0),
(1287, 128, 'Детская посуда', 0, 'detskaya-posuda', 0),
(1288, 128, 'Детское питание', 0, 'detskoe-pitanie', 0),
(1289, 128, 'Молокоотсосы', 0, 'molokootsosy', 0),
(1290, 128, 'Нагрудники, слюнявчики', 0, 'nagrudniki-slyunyavchiki', 0),
(1291, 128, 'Накладки для груди', 0, 'nakladki-dlya-grudi', 0),
(1292, 128, 'Поильники', 0, 'poilniki', 0),
(1293, 128, 'Соски', 0, 'soski', 0),
(1294, 128, 'Стерилизаторы, подогреватели', 0, 'sterilizatory-podogrevateli', 0),
(1295, 128, 'Хранение грудного молока', 0, 'hranenie-grudnogo-moloka', 0),
(1296, 129, 'Ванночки', 0, 'vannochki', 0),
(1297, 129, 'Круги на шею', 0, 'krugi-na-sheyu', 0),
(1298, 129, 'Мочалки, губки', 0, 'mochalki-gubki', 0),
(1299, 129, 'Нарукавники', 0, 'narukavniki', 0),
(1300, 129, 'Сиденья, горки', 0, 'sidenya-gorki', 0),
(1301, 129, 'Шампуни, мыло', 0, 'shampuni-mylo', 0),
(1302, 130, 'Шампуни, мыло', 0, 'shampuni-mylo', 0),
(1303, 130, 'Качели, шезлонги', 0, 'kacheli-shezlongi', 0),
(1304, 130, 'Колыбели, люльки', 0, 'kolybeli-lyulki', 0),
(1305, 130, 'Кроватки', 0, 'krovatki', 0),
(1306, 130, 'Манежи', 0, 'manezhi', 0),
(1307, 130, 'Ночники', 0, 'nochniki', 0),
(1308, 130, 'Пеленальные столики', 0, 'pelenalnye-stoliki', 0),
(1309, 130, 'Постельные принадлежности', 0, 'postelnye-prinadlezhnosti', 0),
(1310, 130, 'Ростомеры', 0, 'rostomery', 0),
(1311, 130, 'Стульчики для кормления', 0, 'stulchiki-dlya-kormleniya', 0),
(1312, 130, 'Ходунки, прыгунки', 0, 'hodunki-prygunki', 0),
(1313, 131, 'Горшки, сиденья', 0, 'gorshki-sidenya', 0),
(1314, 131, 'Накопители подгузников', 0, 'nakopiteli-podguznikov', 0),
(1315, 131, 'Пеленки, клеенки', 0, 'pelenki-kleenki', 0),
(1316, 131, 'Подгузники', 0, 'podguzniki', 0),
(1317, 132, 'Бандажи', 0, 'bandazhi', 0),
(1318, 132, 'Подушки, кресла для мам', 0, 'podushki-kresla-dlya-mam', 0),
(1319, 132, 'Сумки-кенгуру, слинги', 0, 'sumki-kenguru-slingi', 0),
(1320, 133, 'Глобусы, карты', 0, 'globusy-karty', 0),
(1321, 133, 'Доски, мольберты', 0, 'doski-molberty', 0),
(1322, 133, 'Канцтовары', 0, 'kanctovary', 0),
(1323, 133, 'Пеналы', 0, 'penaly', 0),
(1324, 133, 'Учебники', 0, 'uchebniki', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `uni_category_board`
--

CREATE TABLE `uni_category_board` (
  `category_board_id` int(11) NOT NULL,
  `category_board_name` varchar(150) CHARACTER SET utf8 NOT NULL,
  `category_board_visible` int(11) NOT NULL DEFAULT '1',
  `category_board_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_board_id_position` int(11) NOT NULL DEFAULT '0',
  `category_board_text` text CHARACTER SET utf8,
  `category_board_id_parent` int(11) NOT NULL DEFAULT '0',
  `category_board_image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_board_description` text CHARACTER SET utf8,
  `category_board_alias` varchar(255) CHARACTER SET utf8 NOT NULL,
  `category_board_count_view` int(11) NOT NULL DEFAULT '0',
  `category_board_date_view` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_board_price` float NOT NULL DEFAULT '0',
  `category_board_count_free` int(11) NOT NULL DEFAULT '0',
  `category_board_status_paid` int(11) NOT NULL DEFAULT '0',
  `category_board_display_price` int(1) NOT NULL DEFAULT '1',
  `category_board_auction` int(11) NOT NULL DEFAULT '0',
  `category_board_secure` int(11) NOT NULL DEFAULT '0',
  `category_board_h1` varchar(255) DEFAULT NULL,
  `category_board_auto_title` int(1) NOT NULL DEFAULT '0',
  `category_board_online_view` int(1) NOT NULL DEFAULT '0',
  `category_board_auto_title_template` varchar(255) DEFAULT NULL,
  `category_board_show_index` int(1) NOT NULL DEFAULT '0',
  `category_board_marketplace` int(1) NOT NULL DEFAULT '0',
  `category_board_booking` int(1) NOT NULL DEFAULT '0',
  `category_board_booking_variant` int(1) NOT NULL DEFAULT '0',
  `category_board_variant_price_id` int(11) NOT NULL DEFAULT '0',
  `category_board_measures_price` text,
  `category_board_rules` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_category_board`
--

INSERT INTO `uni_category_board` (`category_board_id`, `category_board_name`, `category_board_visible`, `category_board_title`, `category_board_id_position`, `category_board_text`, `category_board_id_parent`, `category_board_image`, `category_board_description`, `category_board_alias`, `category_board_count_view`, `category_board_date_view`, `category_board_price`, `category_board_count_free`, `category_board_status_paid`, `category_board_display_price`, `category_board_auction`, `category_board_secure`, `category_board_h1`, `category_board_auto_title`, `category_board_online_view`, `category_board_auto_title_template`, `category_board_show_index`, `category_board_marketplace`, `category_board_booking`, `category_board_booking_variant`, `category_board_variant_price_id`, `category_board_measures_price`, `category_board_rules`) VALUES
(186, 'Автокресла', 1, 'Автокресла', 54, '', 0, NULL, '', 'avtokresla', 0, '2020-10-12 19:05:42', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(187, 'Здоровье и уход', 1, 'Здоровье и уход', 55, '', 0, NULL, '', 'zdorove-i-uhod', 0, '2020-10-12 19:05:44', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(188, 'Игрушки и игры', 1, 'Игрушки и игры', 56, '', 0, NULL, '', 'igrushki-i-igri', 0, '2020-10-12 19:05:46', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(189, 'Коляски', 1, 'Коляски', 57, '', 0, NULL, '', 'kolyaski', 0, '2020-10-12 19:05:47', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(190, 'Кормление и питание', 1, 'Кормление и питание', 58, '', 0, NULL, '', 'kormlenie-i-pitanie', 0, '2020-10-12 19:05:49', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(191, 'Купание', 1, 'Купание', 59, '', 0, NULL, '', 'kupanie', 0, '2020-10-12 19:05:51', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(192, 'Обустройство детской', 1, 'Обустройство детской', 60, '', 0, NULL, '', 'obustroystvo-detskoy', 0, '2020-10-12 19:05:53', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(193, 'Подгузники и горшки', 1, 'Подгузники и горшки', 61, '', 0, NULL, '', 'podguzniki-i-gorshki', 0, '2020-10-12 19:05:55', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(194, 'Радио- и видеоняни', 1, 'Радио- и видеоняни', 62, '', 0, NULL, '', 'radio-i-videonyani', 0, '2020-10-12 19:05:56', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(195, 'Товары для мам', 1, 'Товары для мам', 63, '', 0, NULL, '', 'tovari-dlya-mam', 0, '2020-10-12 19:05:59', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(196, 'Товары для учебы', 1, 'Товары для учебы', 64, '', 0, NULL, '', 'tovari-dlya-uchebi', 0, '2020-10-12 19:06:01', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(197, 'Другое', 1, 'Другое', 65, '', 0, NULL, '', 'drugoe', 0, '2020-10-12 19:06:03', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(228, 'Детская одежда и обувь', 1, 'Детская одежда и обувь', 53, '', 0, NULL, '', 'detskaya-odezhda-i-obuv', 0, '2020-10-12 19:06:04', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `uni_ads_filters`
--
ALTER TABLE `uni_ads_filters`
  ADD PRIMARY KEY (`ads_filters_id`);

--
-- Индексы таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  ADD PRIMARY KEY (`ads_filters_alias_id`);

--
-- Индексы таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  ADD PRIMARY KEY (`ads_filters_category_id`);

--
-- Индексы таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  ADD PRIMARY KEY (`ads_filters_items_id`),
  ADD KEY `id_filter` (`ads_filters_items_id_filter`);

--
-- Индексы таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  ADD PRIMARY KEY (`category_board_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `uni_ads_filters`
--
ALTER TABLE `uni_ads_filters`
  MODIFY `ads_filters_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  MODIFY `ads_filters_alias_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  MODIFY `ads_filters_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1017;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  MODIFY `ads_filters_items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6308;
--
-- AUTO_INCREMENT для таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  MODIFY `category_board_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=427;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
