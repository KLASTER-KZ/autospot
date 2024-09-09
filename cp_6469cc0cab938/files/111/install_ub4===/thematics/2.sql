-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Сен 27 2022 г., 21:53
-- Версия сервера: 5.7.39-0ubuntu0.18.04.2
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
(3, 'Тип квартиры', 1, 'select', 2, 1, 0, 'tip-kvartiri', 1),
(4, 'Комнат в квартире', 1, 'select', 3, 1, 0, 'komnat-v-kvartire', 1),
(5, 'Общая площадь, м²', 1, 'input', 5, 1, 0, 'obshchaya-ploshchad', 1),
(6, 'Кто разместил', 1, 'select', 1, 1, 0, 'kto-razmestil', 1),
(7, 'Этаж', 1, 'input', 4, 1, 0, 'etazh', 1),
(8, 'Балкон', 1, 'select', 8, 1, 0, 'balkon', 0),
(11, 'До метро', 1, 'select', 10, 1, 0, 'do-metro', 0),
(12, 'Площадь кухни, м²', 1, 'input', 6, 1, 0, 'ploshchad-kuhni-m', 0),
(13, 'Этажность дома', 1, 'input', 11, 1, 0, 'etazhnost-doma', 0),
(14, 'Тип дома', 1, 'select', 9, 1, 0, 'tip-doma', 0),
(15, 'Санузлы', 1, 'select', 12, 1, 0, 'sanuzli', 0),
(16, 'Лифт', 1, 'select', 13, 1, 0, 'lift', 0),
(17, 'Ремонт', 1, 'select', 14, 1, 0, 'remont', 0),
(18, 'Год постройки', 1, 'input', 15, 1, 0, 'god-postroyki', 0),
(21, 'Тип дома', 1, 'select', 2, 1, 0, 'tip-doma', 1),
(22, 'Электричество', 1, 'select', 6, 1, 0, 'elektrichestvo', 0),
(23, 'Газ', 1, 'select', 12, 1, 0, 'gaz', 0),
(24, 'Площадь дома, м²', 1, 'input', 14, 1, 0, 'ploshchad-doma-m', 1),
(25, 'Водоснабжение', 1, 'select', 15, 1, 0, 'vodosnabzhenie', 0),
(26, 'Материал дома', 1, 'select', 17, 1, 0, 'material-doma', 0),
(27, 'Тип участка', 1, 'select', 19, 1, 0, 'tip-uchastka', 1),
(28, 'Площадь участка, сот.', 1, 'input', 21, 1, 0, 'ploshchad-uchastka-sot', 1),
(29, 'Санузлы', 1, 'select', 23, 1, 0, 'sanuzli', 0),
(30, 'Отопление', 1, 'select', 25, 1, 0, 'otoplenie', 0),
(31, 'Количество спален', 1, 'input', 27, 1, 0, 'kolichestvo-spalen', 0),
(32, 'Гараж', 1, 'select', 28, 1, 0, 'garazh', 0),
(33, 'Этажей', 1, 'input', 29, 1, 0, 'etazhey', 0),
(34, 'Срок владения', 1, 'select', 7, 1, 0, 'srok-vladeniya', 0),
(42, 'Комиссия', 1, 'select', 30, 1, 0, 'komissiya', 0),
(43, 'Стиральная машина', 1, 'select', 31, 1, 0, 'stiralnaya-mashina', 0),
(44, 'Предоплата', 1, 'select', 32, 1, 0, 'predoplata', 0),
(45, 'Коммунальные услуги', 1, 'select', 33, 1, 0, 'kommunalnie-uslugi', 0),
(46, 'Посудомоечная машина', 1, 'select', 34, 1, 0, 'posudomoechnaya-mashina', 0),
(47, 'Холодильник', 1, 'select', 35, 1, 0, 'holodilnik', 0),
(48, 'Ремонт в комнате', 1, 'select', 17, 1, 0, 'remont-v-komnate', 0),
(49, 'Площадь комнаты, м²', 1, 'input', 18, 1, 0, 'ploshchad-komnati-m', 0),
(50, 'Балкон в комнате', 1, 'select', 19, 1, 0, 'balkon-v-komnate', 0),
(52, 'Тип строения', 1, 'select', 39, 1, 0, 'tip-stroeniya', 1),
(54, 'Площадь, м²', 1, 'input', 40, 1, 0, 'ploshchad-m2', 0),
(56, 'Торг', 1, 'select', 16, 1, 0, 'torg', 0);

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
  `filters_alias_alias_desc` text,
  `filters_alias_alias_h1` varchar(255) DEFAULT NULL
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
(201, 12, 6),
(200, 11, 6),
(3, 11, 3),
(4, 12, 3),
(5, 13, 3),
(6, 14, 3),
(7, 11, 4),
(8, 12, 4),
(9, 13, 4),
(10, 14, 4),
(94, 16, 25),
(93, 15, 25),
(92, 16, 24),
(91, 15, 24),
(174, 14, 5),
(173, 13, 5),
(172, 12, 5),
(171, 11, 5),
(23, 11, 7),
(24, 12, 7),
(25, 13, 7),
(26, 14, 7),
(27, 11, 8),
(28, 12, 8),
(29, 13, 8),
(30, 14, 8),
(31, 11, 11),
(32, 12, 11),
(33, 13, 11),
(34, 14, 11),
(35, 11, 12),
(36, 12, 12),
(37, 13, 12),
(38, 14, 12),
(39, 15, 12),
(40, 16, 12),
(41, 11, 13),
(42, 12, 13),
(43, 13, 13),
(44, 14, 13),
(68, 14, 16),
(67, 13, 16),
(60, 14, 14),
(59, 13, 14),
(58, 12, 14),
(57, 11, 14),
(66, 12, 16),
(65, 11, 16),
(64, 14, 15),
(63, 13, 15),
(62, 12, 15),
(61, 11, 15),
(69, 11, 17),
(70, 12, 17),
(71, 13, 17),
(72, 14, 17),
(73, 11, 18),
(74, 12, 18),
(75, 13, 18),
(76, 14, 18),
(77, 15, 21),
(78, 16, 21),
(79, 15, 22),
(80, 16, 22),
(81, 15, 23),
(82, 16, 23),
(95, 15, 26),
(96, 16, 26),
(97, 15, 27),
(98, 15, 28),
(99, 16, 28),
(100, 15, 29),
(101, 16, 29),
(102, 15, 30),
(103, 16, 30),
(104, 15, 31),
(105, 16, 31),
(106, 15, 32),
(107, 16, 32),
(108, 15, 33),
(109, 16, 33),
(183, 20, 34),
(182, 19, 34),
(181, 17, 34),
(180, 15, 34),
(179, 13, 34),
(178, 11, 34),
(202, 13, 6),
(199, 21, 42),
(198, 18, 42),
(197, 16, 42),
(196, 14, 42),
(195, 12, 42),
(123, 12, 43),
(124, 14, 43),
(125, 16, 43),
(204, 15, 6),
(190, 18, 44),
(189, 16, 44),
(188, 14, 44),
(187, 12, 44),
(203, 14, 6),
(194, 21, 45),
(193, 16, 45),
(192, 14, 45),
(191, 12, 45),
(205, 16, 6),
(186, 16, 46),
(185, 14, 46),
(184, 12, 46),
(177, 16, 47),
(176, 14, 47),
(175, 12, 47),
(170, 21, 54),
(162, 14, 48),
(161, 13, 48),
(148, 13, 49),
(149, 14, 49),
(150, 13, 50),
(151, 14, 50),
(152, 20, 52),
(153, 21, 52),
(169, 20, 54),
(168, 20, 56),
(167, 19, 56),
(166, 17, 56),
(165, 15, 56),
(164, 13, 56),
(163, 11, 56);

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
(6, 3, 'Вторичка', 0, 'vtorichka', 0),
(7, 3, 'Новостройка', 0, 'novostroyka', 0),
(8, 4, '1 комната', 0, '1-komnata', 0),
(9, 4, '2 комнаты', 0, '2-komnaty', 0),
(10, 4, '3 комнаты', 0, '3-komnaty', 0),
(11, 4, '4 комнаты', 0, '4-komnaty', 0),
(12, 4, '5 и более комнат', 0, '5-i-bolee-komnat', 0),
(13, 4, 'Свободная планировка', 0, 'svobodnaya-planirovka', 0),
(14, 4, 'Студия', 0, 'studiya', 0),
(15, 5, '1', 0, '1', 0),
(16, 5, '1000000', 0, '1000000', 0),
(17, 6, 'Собственник', 0, 'sobstvennik', 0),
(18, 6, 'Агент', 0, 'agent', 0),
(19, 7, '1', 0, '1', 0),
(20, 7, '500', 0, '500', 0),
(21, 8, 'Нет', 0, 'net', 0),
(22, 8, 'Балкон', 0, 'balkon', 0),
(23, 8, 'Лоджия', 0, 'lodzhiya', 0),
(24, 8, 'Несколько балконов', 0, 'neskolko-balkonov', 0),
(32, 11, '5 - 15 мин. пешком', 0, '5-15-min-peshkom', 0),
(31, 11, 'До 5 мин. пешком', 0, 'do-5-min-peshkom', 0),
(33, 11, 'Более 15 мин. пешком', 0, 'bolee-15-min-peshkom', 0),
(34, 11, 'На транспорте', 0, 'na-transporte', 0),
(35, 12, '1', 0, '1', 0),
(36, 12, '1000000', 0, '1000000', 0),
(37, 13, '1', 0, '1', 0),
(38, 13, '500', 0, '500', 0),
(39, 14, 'Панельный', 0, 'panelnyy', 0),
(40, 14, 'Кирпичный', 0, 'kirpichnyy', 0),
(41, 14, 'Монолит', 0, 'monolit', 0),
(42, 14, 'Кирпично-монолитный', 0, 'kirpichno-monolitnyy', 0),
(43, 14, 'Блочный', 0, 'blochnyy', 0),
(44, 14, 'Деревянный', 0, 'derevyannyy', 0),
(45, 15, 'Совмещенный', 0, 'sovmeshchennyy', 0),
(46, 15, 'Раздельный', 0, 'razdelnyy', 0),
(47, 15, '2 и более', 0, '2-i-bolee', 0),
(48, 16, 'Нет', 0, 'net', 0),
(49, 16, 'Легковой', 0, 'legkovoy', 0),
(50, 16, 'Легковой и грузовой', 0, 'legkovoy-i-gruzovoy', 0),
(51, 16, '3 и более лифтов', 0, '3-i-bolee-liftov', 0),
(52, 17, 'Требуется ремонт', 0, 'trebuetsya-remont', 0),
(53, 17, 'Не требуется', 0, 'ne-trebuetsya', 0),
(54, 17, 'Косметический', 0, 'kosmeticheskiy', 0),
(55, 17, 'Евроремонт', 0, 'evroremont', 0),
(56, 17, 'Дизайнерский', 0, 'dizaynerskiy', 0),
(57, 17, 'Капитальный ремонт', 0, 'kapitalnyy-remont', 0),
(58, 18, '1800', 0, '1800', 0),
(59, 18, '2020', 0, '2020', 0),
(65, 21, 'Дом', 0, 'dom', 0),
(66, 21, 'Таунхаус', 0, 'taunhaus', 0),
(67, 21, 'Коттедж', 0, 'kottedzh', 0),
(68, 21, 'Дача', 0, 'dacha', 0),
(69, 22, 'Нет', 0, 'net', 0),
(70, 22, 'Есть', 0, 'est', 0),
(71, 23, 'Нет', 0, 'net', 0),
(72, 23, 'По границе', 0, 'po-granice', 0),
(73, 23, 'Подведен', 0, 'podveden', 0),
(74, 24, '1', 0, '1', 0),
(75, 24, '1000000', 0, '1000000', 0),
(76, 25, 'Нет', 0, 'net', 0),
(77, 25, 'Автономное', 0, 'avtonomnoe', 0),
(78, 25, 'Централизованное', 0, 'centralizovannoe', 0),
(79, 26, 'Кирпичный', 0, 'kirpichnyy', 0),
(80, 26, 'Деревянный', 0, 'derevyannyy', 0),
(81, 26, 'Щитовой', 0, 'shchitovoy', 0),
(82, 26, 'Монолитный', 0, 'monolitnyy', 0),
(83, 26, 'Блочный', 0, 'blochnyy', 0),
(84, 27, 'Сельхоз (СНТ или ДНП)', 0, 'selhoz-snt-ili-dnp', 0),
(85, 27, 'Фермерское хоз-во', 0, 'fermerskoe-hoz-vo', 0),
(86, 27, 'Поселения (ИЖС)', 0, 'poseleniya-izhs', 0),
(87, 27, 'Земля промназначения', 0, 'zemlya-promnaznacheniya', 0),
(88, 27, 'Инвестпроект', 0, 'investproekt', 0),
(89, 28, '1', 0, '1', 0),
(90, 28, '1000000', 0, '1000000', 0),
(91, 29, 'На улице', 0, 'na-ulice', 0),
(92, 29, 'В доме', 0, 'v-dome', 0),
(93, 29, 'Несколько санузлов', 0, 'neskolko-sanuzlov', 0),
(94, 30, 'Нет', 0, 'net', 0),
(95, 30, 'Автономное', 0, 'avtonomnoe', 0),
(96, 30, 'Централизованное', 0, 'centralizovannoe', 0),
(97, 31, '1', 0, '1', 0),
(98, 31, '100', 0, '100', 0),
(99, 32, 'Нет', 0, 'net', 0),
(100, 32, 'В доме', 0, 'v-dome', 0),
(101, 32, 'Отдельно стоящий', 0, 'otdelno-stoyashchiy', 0),
(102, 33, '1', 0, '1', 0),
(103, 33, '100', 0, '100', 0),
(104, 34, 'До 3-х лет', 0, 'do-3-h-let', 0),
(105, 34, 'От 3 до 5 лет', 0, 'ot-3-do-5-let', 0),
(106, 34, 'Более 5 лет', 0, 'bolee-5-let', 0),
(131, 42, '50%', 0, '50', 0),
(130, 42, '30%', 0, '30', 0),
(129, 42, 'Нет', 0, 'net', 0),
(132, 42, '100%', 0, '100', 0),
(133, 42, 'Другая', 0, 'drugaya', 0),
(134, 43, 'Есть', 0, 'est', 0),
(135, 43, 'Нет', 0, 'net', 0),
(136, 44, 'Без предоплаты', 0, 'bez-predoplaty', 0),
(137, 44, '1 месяц', 0, '1-mesyac', 0),
(138, 44, '2 месяца', 0, '2-mesyaca', 0),
(139, 44, '3 месяца', 0, '3-mesyaca', 0),
(140, 44, '4 и более месяцев', 0, '4-i-bolee-mesyacev', 0),
(141, 45, 'Включены', 0, 'vklyucheny', 0),
(142, 45, 'Не включены', 0, 'ne-vklyucheny', 0),
(143, 46, 'Есть', 0, 'est', 0),
(144, 46, 'Нет', 0, 'net', 0),
(145, 47, 'Есть', 0, 'est', 0),
(146, 47, 'Нет', 0, 'net', 0),
(147, 48, 'Требуется ремонт', 0, 'trebuetsya-remont', 0),
(148, 48, 'Не требуется', 0, 'ne-trebuetsya', 0),
(149, 48, 'Косметический', 0, 'kosmeticheskiy', 0),
(150, 48, 'Евроремонт', 0, 'evroremont', 0),
(151, 48, 'Дизайнерский', 0, 'dizaynerskiy', 0),
(152, 48, 'Капитальный ремонт', 0, 'kapitalnyy-remont', 0),
(153, 49, '1', 0, '1', 0),
(154, 49, '1000000', 0, '1000000', 0),
(155, 50, 'Нет', 0, 'net', 0),
(156, 50, 'Балкон', 0, 'balkon', 0),
(157, 50, 'Лоджия', 0, 'lodzhiya', 0),
(158, 50, 'Несколько балконов', 0, 'neskolko-balkonov', 0),
(188, 52, 'Помещение свободного назначения', 0, 'pomeshchenie-svobodnogo-naznacheniya', 0),
(189, 52, 'Торговое помещение', 0, 'torgovoe-pomeshchenie', 0),
(190, 52, 'Офисное помещение', 0, 'ofisnoe-pomeshchenie', 0),
(191, 52, 'Производство', 0, 'proizvodstvo', 0),
(192, 52, 'Склад', 0, 'sklad', 0),
(193, 52, 'Другая коммерческая недвижимость', 0, 'drugaya-kommercheskaya-nedvizhimost', 0),
(196, 54, '1', 0, '1', 0),
(197, 54, '1000000', 0, '1000000', 0),
(204, 56, 'Да', 0, 'da', 0),
(205, 56, 'Нет', 0, 'net', 0);

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
  `category_board_display_price` float DEFAULT '0',
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
(5, 'Дома, дачи, коттеджи', 1, 'Дома, дачи, коттеджи', 3, '', 0, NULL, '', 'doma-dachi-kottedzhi', 0, '2020-10-11 13:53:16', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(4, 'Квартиры', 1, 'Квартиры', 1, '', 0, NULL, '', 'kvartiry', 0, '2020-10-11 13:53:12', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(6, 'Земельные участки', 1, 'Земельные участки', 5, '', 0, NULL, '', 'zemelnye-uchastki', 0, '2020-10-12 10:14:23', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(7, 'Коммерческая недвижимость', 1, 'Коммерческая недвижимость', 6, '', 0, NULL, '', 'kommercheskaya-nedvizhimost', 0, '2020-10-12 10:14:23', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(8, 'Комнаты', 1, 'Комнаты', 2, '', 0, NULL, '', 'komnaty', 0, '2020-10-11 13:53:16', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(9, 'Недвижимость за рубежом', 1, 'Недвижимость за рубежом', 7, '', 0, NULL, '', 'nedvizhimost-za-rubezhom', 0, '2020-10-12 10:14:23', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(10, 'Гаражи и машиноместа', 1, 'Гаражи и машиноместа', 4, '', 0, NULL, '', 'garazhi-i-mashinomesta', 0, '2020-10-12 10:14:23', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(11, 'Продажа', 1, 'Продажа', 0, '', 4, NULL, '', 'prodazha', 0, '2020-10-12 11:07:07', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(12, 'Аренда', 1, 'Аренда', 0, '', 4, NULL, '', 'arenda', 0, '2020-10-12 11:07:36', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(13, 'Продажа', 1, 'Продажа', 0, '', 8, NULL, '', 'prodazha', 0, '2020-10-12 11:08:28', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(14, 'Аренда', 1, 'Аренда', 0, '', 8, NULL, '', 'arenda', 0, '2020-10-12 11:08:43', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(15, 'Продажа', 1, 'Продажа', 0, '', 5, NULL, '', 'prodazha', 0, '2020-10-12 11:09:21', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(16, 'Аренда', 1, 'Аренда', 0, '', 5, NULL, '', 'arenda', 0, '2020-10-12 11:09:37', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(17, 'Продажа', 1, 'Продажа', 0, '', 10, NULL, '', 'prodazha', 0, '2020-10-12 11:09:54', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(18, 'Аренда', 1, 'Аренда', 0, '', 10, NULL, '', 'arenda', 0, '2020-10-12 11:10:08', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(19, 'Продажа', 1, 'Продажа', 0, '', 6, NULL, '', 'prodazha', 0, '2020-10-12 11:10:29', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(20, 'Продажа', 1, 'Продажа', 0, '', 7, NULL, '', 'prodazha', 0, '2020-10-12 11:11:03', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(21, 'Аренда', 1, 'Аренда', 0, '', 7, NULL, '', 'arenda', 0, '2020-10-12 11:11:17', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(22, 'Продажа', 1, 'Продажа', 0, '', 9, NULL, '', 'prodazha', 0, '2020-10-12 11:14:23', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(23, 'Аренда', 1, 'Аренда', 0, '', 9, NULL, '', 'arenda', 0, '2020-10-12 11:18:32', 0, 1, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

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
  MODIFY `ads_filters_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  MODIFY `ads_filters_items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6308;
--
-- AUTO_INCREMENT для таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  MODIFY `category_board_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
