-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 18 2022 г., 22:34
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
(60, 'Вид услуг', 1, 'select', 51, 1, 0, 'vid-uslug', 1),
(61, 'Вид услуг', 1, 'select', 52, 1, 0, 'vid-uslug', 1),
(62, 'Вид услуг', 1, 'select', 53, 1, 0, 'vid-uslug', 1),
(63, 'Вид услуг', 1, 'select', 54, 1, 0, 'vid-uslug', 1),
(64, 'Вид услуг', 1, 'select', 55, 1, 0, 'vid-uslug', 1),
(65, 'Вид услуг', 1, 'select', 56, 1, 0, 'vid-uslug', 1),
(66, 'Вид услуг', 1, 'select', 57, 1, 0, 'vid-uslug', 1),
(67, 'Вид услуг', 1, 'select', 58, 1, 0, 'vid-uslug', 1),
(68, 'Вид услуг', 1, 'select', 59, 1, 0, 'vid-uslug', 1),
(69, 'Вид услуг', 1, 'select', 60, 1, 0, 'vid-uslug', 1),
(70, 'Вид услуг', 1, 'select', 61, 1, 0, 'vid-uslug', 1),
(71, 'Вид услуг', 1, 'select', 62, 1, 0, 'vid-uslug', 1),
(72, 'Вид услуг', 1, 'select', 63, 1, 0, 'vid-uslug', 1),
(73, 'Вид услуг', 1, 'select', 64, 1, 0, 'vid-uslug', 1),
(74, 'Вид услуг', 1, 'select', 65, 1, 0, 'vid-uslug', 1);

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
(722, 161, 60),
(720, 162, 61),
(721, 163, 62),
(723, 164, 63),
(724, 165, 64),
(725, 166, 65),
(726, 167, 66),
(727, 168, 67),
(728, 169, 68),
(729, 170, 69),
(730, 171, 70),
(731, 172, 71),
(732, 173, 72),
(733, 174, 73),
(734, 175, 74);

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
(230, 60, 'Артистические дисциплины', 0, 'artisticheskie-discipliny', 0),
(231, 60, 'Вождение (АКПП)', 0, 'vozhdenie-akpp', 0),
(232, 60, 'Вождение (МКПП)', 0, 'vozhdenie-mkpp', 0),
(233, 60, 'Вождение квадроцикла', 0, 'vozhdenie-kvadrocikla', 0),
(234, 60, 'Вождение мотоцикла', 0, 'vozhdenie-motocikla', 0),
(235, 60, 'Вождение снегохода', 0, 'vozhdenie-snegohoda', 0),
(236, 60, 'Детское развитие', 0, 'detskoe-razvitie', 0),
(237, 60, 'Единоборства', 0, 'edinoborstva', 0),
(238, 60, 'Игровые виды спорта', 0, 'igrovye-vidy-sporta', 0),
(239, 60, 'Индивидуальные виды спорта', 0, 'individualnye-vidy-sporta', 0),
(240, 60, 'Лёгкая атлетика', 0, 'legkaya-atletika', 0),
(241, 60, 'Мастер-классы, тренинги', 0, 'master-klassy-treningi', 0),
(242, 60, 'Многоборье', 0, 'mnogobore', 0),
(243, 60, 'Обучение автоинструкторов', 0, 'obuchenie-avtoinstruktorov', 0),
(244, 60, 'Обучение бухгалтерскому учёту', 0, 'obuchenie-buhgalterskomu-uchetu', 0),
(245, 60, 'Обучение вождению', 0, 'obuchenie-vozhdeniyu', 0),
(246, 60, 'Обучение игры на гитаре', 0, 'obuchenie-igry-na-gitare', 0),
(247, 60, 'Обучение игры на флейте', 0, 'obuchenie-igry-na-fleyte', 0),
(248, 60, 'Обучение языкам', 0, 'obuchenie-yazykam', 0),
(249, 60, 'Оздоровительные дисциплины', 0, 'ozdorovitelnye-discipliny', 0),
(250, 60, 'ПДД (теория)', 0, 'pdd-teoriya', 0),
(251, 60, 'Подготовка к школе', 0, 'podgotovka-k-shkole', 0),
(252, 60, 'Подготовка к экзаменам', 0, 'podgotovka-k-ekzamenam', 0),
(253, 60, 'Программы вождения', 0, 'programmy-vozhdeniya', 0),
(254, 60, 'Профессиональное обучение', 0, 'professionalnoe-obuchenie', 0),
(255, 60, 'Силовые виды спорта', 0, 'silovye-vidy-sporta', 0),
(256, 60, 'Сложнокоординационные виды спорта', 0, 'slozhnokoordinacionnye-vidy-sporta', 0),
(257, 60, 'Технические виды спорта', 0, 'tehnicheskie-vidy-sporta', 0),
(258, 60, 'Тренера, другое', 0, 'trenera-drugoe', 0),
(259, 60, 'Уроки музыки, театрального мастерства', 0, 'uroki-muzyki-teatralnogo-masterstva', 0),
(260, 60, 'Уроки рисования, дизайна, рукоделия', 0, 'uroki-risovaniya-dizayna-rukodeliya', 0),
(261, 60, 'Услуги логопеда, дефектолога', 0, 'uslugi-logopeda-defektologa', 0),
(262, 60, 'Услуги психолога', 0, 'uslugi-psihologa', 0),
(263, 60, 'Услуги репетитора', 0, 'uslugi-repetitora', 0),
(264, 60, 'Услуги тренера (фитнес, спорт, танцы)', 0, 'uslugi-trenera-fitnes-sport-tancy', 0),
(265, 60, 'Циклические виды спорта', 0, 'ciklicheskie-vidy-sporta', 0),
(266, 60, 'Экстремальное вождение', 0, 'ekstremalnoe-vozhdenie', 0),
(267, 60, 'Экстремальные виды спорта', 0, 'ekstremalnye-vidy-sporta', 0),
(268, 61, 'Дезинфекция, дезинсекция', 0, 'dezinfekciya-dezinsekciya', 0),
(269, 61, 'Изготовление ключей, вскрытие замков', 0, 'izgotovlenie-klyuchey-vskrytie-zamkov', 0),
(270, 61, 'Муж на час', 0, 'muzh-na-chas', 0),
(271, 61, 'Сборка и ремонт мебели', 0, 'sborka-i-remont-mebeli', 0),
(272, 61, 'Услуги няни, гувернантки', 0, 'uslugi-nyani-guvernantki', 0),
(273, 61, 'Услуги сиделки', 0, 'uslugi-sidelki', 0),
(274, 62, 'Аренда кабинета', 0, 'arenda-kabineta', 0),
(275, 62, 'Депиляция, шугаринг', 0, 'depilyaciya-shugaring', 0),
(276, 62, 'Загар', 0, 'zagar', 0),
(277, 62, 'Лечение волос', 0, 'lechenie-volos', 0),
(278, 62, 'Макияж', 0, 'makiyazh', 0),
(279, 62, 'Маникюр, педикюр', 0, 'manikyur-pedikyur', 0),
(280, 62, 'Массаж', 0, 'massazh', 0),
(281, 62, 'Наращивание волос', 0, 'narashchivanie-volos', 0),
(282, 62, 'Наращивание ресниц, услуги бровиста', 0, 'narashchivanie-resnic-uslugi-brovista', 0),
(283, 62, 'Пирсинг', 0, 'pirsing', 0),
(284, 62, 'СПА-услуги', 0, 'spa-uslugi', 0),
(285, 62, 'Свадебный стилист', 0, 'svadebnyy-stilist', 0),
(286, 62, 'Стилист-имиджмейкер', 0, 'stilist-imidzhmeyker', 0),
(287, 62, 'Стилисты и имиджмейкеры', 0, 'stilisty-i-imidzhmeykery', 0),
(288, 62, 'Тату', 0, 'tatu', 0),
(289, 62, 'Татуаж', 0, 'tatuazh', 0),
(290, 62, 'Услуги парикмахера', 0, 'uslugi-parikmahera', 0),
(291, 63, 'Аренда авто', 0, 'arenda-avto', 0),
(292, 63, 'Аренда спецтехники', 0, 'arenda-spectehniki', 0),
(293, 63, 'Вывоз мусора', 0, 'vyvoz-musora', 0),
(294, 63, 'Грузоперевозки', 0, 'gruzoperevozki', 0),
(295, 63, 'Грузчики', 0, 'gruzchiki', 0),
(296, 63, 'Курьер на авто', 0, 'kurer-na-avto', 0),
(297, 63, 'Пассажирские перевозки', 0, 'passazhirskie-perevozki', 0),
(298, 63, 'Пеший курьер', 0, 'peshiy-kurer', 0),
(299, 63, 'Услуги водителя', 0, 'uslugi-voditelya', 0),
(300, 63, 'Услуги эвакуатора', 0, 'uslugi-evakuatora', 0),
(301, 64, 'Аварийное вскрытие замков', 0, 'avariynoe-vskrytie-zamkov', 0),
(302, 64, 'Благоустройство территории', 0, 'blagoustroystvo-territorii', 0),
(303, 64, 'Вентиляция и кондиционеры', 0, 'ventilyaciya-i-kondicionery', 0),
(304, 64, 'Возведение стен и перегородок', 0, 'vozvedenie-sten-i-peregorodok', 0),
(305, 64, 'Высотные работы', 0, 'vysotnye-raboty', 0),
(306, 64, 'Гипсокартонные работы', 0, 'gipsokartonnye-raboty', 0),
(307, 64, 'Декоративно-прикладные работы', 0, 'dekorativno-prikladnye-raboty', 0),
(308, 64, 'Демонтаж сооружений и конструкций', 0, 'demontazh-sooruzheniy-i-konstrukciy', 0),
(309, 64, 'Дизайн интерьера', 0, 'dizayn-interera', 0),
(310, 64, 'Дома и коттеджи «под ключ»', 0, 'doma-i-kottedzhi-pod-klyuch', 0),
(311, 64, 'Инженерные изыскания', 0, 'inzhenernye-izyskaniya', 0),
(312, 64, 'Кровельные работы', 0, 'krovelnye-raboty', 0),
(313, 64, 'Кузнечное дело', 0, 'kuznechnoe-delo', 0),
(314, 64, 'Лазерная резка и гравировка', 0, 'lazernaya-rezka-i-gravirovka', 0),
(315, 64, 'Малярные работы', 0, 'malyarnye-raboty', 0),
(316, 64, 'Мелкий ремонт', 0, 'melkiy-remont', 0),
(317, 64, 'Металлоконструкции', 0, 'metallokonstrukcii', 0),
(318, 64, 'Монтаж отопления', 0, 'montazh-otopleniya', 0),
(319, 64, 'Навесы и тенты', 0, 'navesy-i-tenty', 0),
(320, 64, 'Натяжные потолки', 0, 'natyazhnye-potolki', 0),
(321, 64, 'Остекление, ремонт окон', 0, 'osteklenie-remont-okon', 0),
(322, 64, 'Отделка квартир', 0, 'otdelka-kvartir', 0),
(323, 64, 'Отделочные работы', 0, 'otdelochnye-raboty', 0),
(324, 64, 'Печи и камины', 0, 'pechi-i-kaminy', 0),
(325, 64, 'Поклейка обоев', 0, 'pokleyka-oboev', 0),
(326, 64, 'Проектные работы', 0, 'proektnye-raboty', 0),
(327, 64, 'Ремонт', 0, 'remont', 0),
(328, 64, 'Ремонт квартир', 0, 'remont-kvartir', 0),
(329, 64, 'Ремонт промышленного оборудования', 0, 'remont-promyshlennogo-oborudovaniya', 0),
(330, 64, 'Сборка мебели', 0, 'sborka-mebeli', 0),
(331, 64, 'Сварочные работы', 0, 'svarochnye-raboty', 0),
(332, 64, 'Слесарные работы', 0, 'slesarnye-raboty', 0),
(333, 64, 'Стекольные работы', 0, 'stekolnye-raboty', 0),
(334, 64, 'Столярные работы', 0, 'stolyarnye-raboty', 0),
(335, 64, 'Строительные работы', 0, 'stroitelnye-raboty', 0),
(336, 64, 'Строительство фундаментов', 0, 'stroitelstvo-fundamentov', 0),
(337, 64, 'Токарные работы', 0, 'tokarnye-raboty', 0),
(338, 64, 'Укладка плитки', 0, 'ukladka-plitki', 0),
(339, 64, 'Услуги плотника', 0, 'uslugi-plotnika', 0),
(340, 64, 'Услуги разнорабочих', 0, 'uslugi-raznorabochih', 0),
(341, 64, 'Услуги сантехника', 0, 'uslugi-santehnika', 0),
(342, 64, 'Услуги электрика', 0, 'uslugi-elektrika', 0),
(343, 64, 'Установка и ремонт дверей', 0, 'ustanovka-i-remont-dverey', 0),
(344, 64, 'Фасадные работы', 0, 'fasadnye-raboty', 0),
(345, 64, 'Штукатурные работы', 0, 'shtukaturnye-raboty', 0),
(346, 65, 'Веб-Дизайн, бренд, арт', 0, 'veb-dizayn-brend-art', 0),
(347, 65, 'Верстальщики', 0, 'verstalshchiki', 0),
(348, 65, 'Дизайнеры', 0, 'dizaynery', 0),
(349, 65, 'Компьютерная анимация, моделирование', 0, 'kompyuternaya-animaciya-modelirovanie', 0),
(350, 65, 'Компьютерная помощь, настройка ПК', 0, 'kompyuternaya-pomoshch-nastroyka-pk', 0),
(351, 65, 'Маркетинг', 0, 'marketing', 0),
(352, 65, 'Набор текста, ввод данных', 0, 'nabor-teksta-vvod-dannyh', 0),
(353, 65, 'Подключение Интернета', 0, 'podklyuchenie-interneta', 0),
(354, 65, 'Поиск и обработка информации', 0, 'poisk-i-obrabotka-informacii', 0),
(355, 65, 'Презентации, инфографика', 0, 'prezentacii-infografika', 0),
(356, 65, 'Программисты', 0, 'programmisty', 0),
(357, 65, 'Промышленный дизайн', 0, 'promyshlennyy-dizayn', 0),
(358, 65, 'Работа с текстами', 0, 'rabota-s-tekstami', 0),
(359, 65, 'Системные администраторы', 0, 'sistemnye-administratory', 0),
(360, 65, 'Создание и продвижение сайтов', 0, 'sozdanie-i-prodvizhenie-saytov', 0),
(361, 65, 'Установка ПО', 0, 'ustanovka-po', 0),
(362, 65, 'Другие IT-услуги', 0, 'drugie-it-uslugi', 0),
(363, 66, 'Адвокаты', 0, 'advokaty', 0),
(364, 66, 'Байеры', 0, 'bayery', 0),
(365, 66, 'Бизнес-консультирование', 0, 'biznes-konsultirovanie', 0),
(366, 66, 'Бизнес-тренеры', 0, 'biznes-trenery', 0),
(367, 66, 'Брачные агентства', 0, 'brachnye-agentstva', 0),
(368, 66, 'Брокеры', 0, 'brokery', 0),
(369, 66, 'Бухгалтерия, финансы', 0, 'buhgalteriya-finansy', 0),
(370, 66, 'Виртуальный помощник', 0, 'virtualnyy-pomoshchnik', 0),
(371, 66, 'Детективы', 0, 'detektivy', 0),
(372, 66, 'Дикторы', 0, 'diktory', 0),
(373, 66, 'Изготовление вывесок, рекламы', 0, 'izgotovlenie-vyvesok-reklamy', 0),
(374, 66, 'Изготовление и монтаж рекламных конструкций и вывесок', 0, 'izgotovlenie-i-montazh-reklamnyh-konstrukciy-i-vyvesok', 0),
(375, 66, 'Интервьюеры', 0, 'intervyuery', 0),
(376, 66, 'Кадровики', 0, 'kadroviki', 0),
(377, 66, 'Консьержи', 0, 'konserzhi', 0),
(378, 66, 'Личный помощник', 0, 'lichnyy-pomoshchnik', 0),
(379, 66, 'Логисты', 0, 'logisty', 0),
(380, 66, 'Маркетинг, реклама, PR', 0, 'marketing-reklama-pr', 0),
(381, 66, 'Обзвон по базе', 0, 'obzvon-po-baze', 0),
(382, 66, 'Охрана труда', 0, 'ohrana-truda', 0),
(383, 66, 'Оценщик', 0, 'ocenshchik', 0),
(384, 66, 'Перевод', 0, 'perevod', 0),
(385, 66, 'Полиграфия, печать, дизайн', 0, 'poligrafiya-pechat-dizayn', 0),
(386, 66, 'Ритуальные услуги', 0, 'ritualnye-uslugi', 0),
(387, 66, 'Риэлторские услуги', 0, 'rieltorskie-uslugi', 0),
(388, 66, 'Санитарно-эпидемиологические услуги', 0, 'sanitarno-epidemiologicheskie-uslugi', 0),
(389, 66, 'Сельскохозяйственные работы', 0, 'selskohozyaystvennye-raboty', 0),
(390, 66, 'Сортировщики', 0, 'sortirovshchiki', 0),
(391, 66, 'Составление документов, сертификации и пр.', 0, 'sostavlenie-dokumentov-sertifikacii-i-pr', 0),
(392, 66, 'Специалисты по тендерам', 0, 'specialisty-po-tenderam', 0),
(393, 66, 'Трейдеры', 0, 'treydery', 0),
(394, 66, 'Управляющий', 0, 'upravlyayushchiy', 0),
(395, 66, 'Хэдхантеры', 0, 'hedhantery', 0),
(396, 66, 'Юридические услуги', 0, 'yuridicheskie-uslugi', 0),
(397, 67, 'Мойка окон, балконов', 0, 'moyka-okon-balkonov', 0),
(398, 67, 'Работы в саду, на участке', 0, 'raboty-v-sadu-na-uchastke', 0),
(399, 67, 'Уборка', 0, 'uborka', 0),
(400, 67, 'Услуги домработницы', 0, 'uslugi-domrabotnicy', 0),
(401, 67, 'Химчистка, стирка, глажка', 0, 'himchistka-stirka-glazhka', 0),
(402, 68, 'Автостекла и зеркала', 0, 'avtostekla-i-zerkala', 0),
(403, 68, 'Автоэлектрика', 0, 'avtoelektrika', 0),
(404, 68, 'Выхлопная система', 0, 'vyhlopnaya-sistema', 0),
(405, 68, 'Детейлинг', 0, 'deteyling', 0),
(406, 68, 'Диагностика, подбор авто', 0, 'diagnostika-podbor-avto', 0),
(407, 68, 'Замена жидкостей', 0, 'zamena-zhidkostey', 0),
(408, 68, 'Кондиционеры и отопление', 0, 'kondicionery-i-otoplenie', 0),
(409, 68, 'Кузовные работы', 0, 'kuzovnye-raboty', 0),
(410, 68, 'Покраска автомобиля', 0, 'pokraska-avtomobilya', 0),
(411, 68, 'Ремонт двигателя', 0, 'remont-dvigatelya', 0),
(412, 68, 'Ремонт мототехники', 0, 'remont-mototehniki', 0),
(413, 68, 'Ремонт подвески', 0, 'remont-podveski', 0),
(414, 68, 'Ремонт рулевого управления', 0, 'remont-rulevogo-upravleniya', 0),
(415, 68, 'Ремонт топливной системы', 0, 'remont-toplivnoy-sistemy', 0),
(416, 68, 'Ремонт тормозной системы', 0, 'remont-tormoznoy-sistemy', 0),
(417, 68, 'Ремонт трансмиссии', 0, 'remont-transmissii', 0),
(418, 68, 'Техническое обслуживание', 0, 'tehnicheskoe-obsluzhivanie', 0),
(419, 68, 'Тюнинг и установка доп. оборудования', 0, 'tyuning-i-ustanovka-dop-oborudovaniya', 0),
(420, 68, 'Химчистка, мойка и полировка', 0, 'himchistka-moyka-i-polirovka', 0),
(421, 68, 'Шиномонтажные работы', 0, 'shinomontazhnye-raboty', 0),
(422, 68, 'Электрооборудование', 0, 'elektrooborudovanie', 0),
(423, 69, 'Ремонт велосипедов', 0, 'remont-velosipedov', 0),
(424, 69, 'Ремонт газового оборудования', 0, 'remont-gazovogo-oborudovaniya', 0),
(425, 69, 'Ремонт инструментов', 0, 'remont-instrumentov', 0),
(426, 69, 'Ремонт компьютеров, ноутбуков', 0, 'remont-kompyuterov-noutbukov', 0),
(427, 69, 'Ремонт компьютеров, телефонов, электроники', 0, 'remont-kompyuterov-telefonov-elektroniki', 0),
(428, 69, 'Ремонт медицинского оборудования', 0, 'remont-medicinskogo-oborudovaniya', 0),
(429, 69, 'Ремонт музыкальных инструментов', 0, 'remont-muzykalnyh-instrumentov', 0),
(430, 69, 'Ремонт оптических приборов', 0, 'remont-opticheskih-priborov', 0),
(431, 69, 'Ремонт садовой техники', 0, 'remont-sadovoy-tehniki', 0),
(432, 69, 'Ремонт смартфонов, телефонов', 0, 'remont-smartfonov-telefonov', 0),
(433, 69, 'Ремонт спортивного инвентаря', 0, 'remont-sportivnogo-inventarya', 0),
(434, 69, 'Ремонт спортинвентаря', 0, 'remont-sportinventarya', 0),
(435, 69, 'Ремонт строительного оборудования', 0, 'remont-stroitelnogo-oborudovaniya', 0),
(436, 69, 'Ремонт телевизоров, аудио, видеотехники', 0, 'remont-televizorov-audio-videotehniki', 0),
(437, 69, 'Ремонт утюгов', 0, 'remont-utyugov', 0),
(438, 69, 'Ремонт фототехники', 0, 'remont-fototehniki', 0),
(439, 69, 'Ремонт часов', 0, 'remont-chasov', 0),
(440, 69, 'Ремонт швейных машин', 0, 'remont-shveynyh-mashin', 0),
(441, 69, 'Установка кондиционеров', 0, 'ustanovka-kondicionerov', 0),
(442, 69, 'Установка систем безопасности', 0, 'ustanovka-sistem-bezopasnosti', 0),
(443, 69, 'Установка, ремонт бытовой техники', 0, 'ustanovka-remont-bytovoy-tehniki', 0),
(444, 70, 'Аренда оборудования, аттракционов', 0, 'arenda-oborudovaniya-attrakcionov', 0),
(445, 70, 'Аренда площадки', 0, 'arenda-ploshchadki', 0),
(446, 70, 'Диджеи', 0, 'didzhei', 0),
(447, 70, 'Организация мероприятий', 0, 'organizaciya-meropriyatiy', 0),
(448, 70, 'Приготовление еды и кейтеринг', 0, 'prigotovlenie-edy-i-keytering', 0),
(449, 70, 'Прокат костюмов', 0, 'prokat-kostyumov', 0),
(450, 70, 'Промоутеры, модели', 0, 'promoutery-modeli', 0),
(451, 70, 'Туризм и отдых', 0, 'turizm-i-otdyh', 0),
(452, 70, 'Цветы и декор', 0, 'cvety-i-dekor', 0),
(453, 71, 'Видеомонтажер', 0, 'videomontazher', 0),
(454, 71, 'Видеооператоры', 0, 'videooperatory', 0),
(455, 71, 'Детские фотографы', 0, 'detskie-fotografy', 0),
(456, 71, 'Печать альбомов и фотокниг', 0, 'pechat-albomov-i-fotoknig', 0),
(457, 71, 'Портретная фотосъемка', 0, 'portretnaya-fotosemka', 0),
(458, 71, 'Предметное фото', 0, 'predmetnoe-foto', 0),
(459, 71, 'Рекламная фотосъемка', 0, 'reklamnaya-fotosemka', 0),
(460, 71, 'Рекламное видео', 0, 'reklamnoe-video', 0),
(461, 71, 'Ретушь и восстановление фото', 0, 'retush-i-vosstanovlenie-foto', 0),
(462, 71, 'Свадебные фотографы', 0, 'svadebnye-fotografy', 0),
(463, 71, 'Студийная фотосъемка', 0, 'studiynaya-fotosemka', 0),
(464, 71, 'Фото архитектуры', 0, 'foto-arhitektury', 0),
(465, 71, 'Фото и видеосъемка, другое', 0, 'foto-i-videosemka-drugoe', 0),
(466, 71, 'Фотосъемка новорожденных', 0, 'fotosemka-novorozhdennyh', 0),
(467, 72, 'Изготовление и ремонт одежды, обуви, аксессуаров', 0, 'izgotovlenie-i-remont-odezhdy-obuvi-aksessuarov', 0),
(468, 72, 'Кованые изделия на заказ', 0, 'kovanye-izdeliya-na-zakaz', 0),
(469, 72, 'Мебель на заказ', 0, 'mebel-na-zakaz', 0),
(470, 72, 'Музыка, стихи, озвучка на заказ', 0, 'muzyka-stihi-ozvuchka-na-zakaz', 0),
(471, 72, 'Печати и штампы на заказ', 0, 'pechati-i-shtampy-na-zakaz', 0),
(472, 72, 'Рисунок, живопись, графика на заказ', 0, 'risunok-zhivopis-grafika-na-zakaz', 0),
(473, 72, 'Сувенирная продукция, полиграфия', 0, 'suvenirnaya-produkciya-poligrafiya', 0),
(474, 72, 'Ювелирные услуги', 0, 'yuvelirnye-uslugi', 0),
(475, 72, 'Другие услуги на заказ', 0, 'drugie-uslugi-na-zakaz', 0),
(476, 73, 'Выпечка, торты на заказ', 0, 'vypechka-torty-na-zakaz', 0),
(477, 73, 'Продукты питания', 0, 'produkty-pitaniya', 0),
(478, 73, 'Услуги повара', 0, 'uslugi-povara', 0),
(479, 73, 'Чай, кофе', 0, 'chay-kofe', 0),
(480, 74, 'Вязка', 0, 'vyazka', 0),
(481, 74, 'Дрессировка и выгул', 0, 'dressirovka-i-vygul', 0),
(482, 74, 'Передержка', 0, 'perederzhka', 0),
(483, 74, 'Стрижка, уход', 0, 'strizhka-uhod', 0),
(484, 74, 'Другие услуги для животных', 0, 'drugie-uslugi-dlya-zhivotnyh', 0);

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
(161, 'Обучение', 1, 'Обучение', 36, '', 0, NULL, '', 'obuchenie', 0, '2020-10-12 18:24:11', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(162, 'Мастер на час', 1, 'Мастер на час', 37, '', 0, NULL, '', 'master-na-chas', 0, '2020-10-12 18:24:14', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(163, 'Красота и здоровье', 1, 'Красота и здоровье', 38, '', 0, NULL, '', 'krasota-i-zdorove', 0, '2020-10-12 18:24:16', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(164, 'Перевозки', 1, 'Перевозки', 39, '', 0, NULL, '', 'perevozki', 0, '2020-10-12 18:24:17', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(165, 'Ремонт и строительство', 1, 'Ремонт и строительство', 40, '', 0, NULL, '', 'remont-i-stroitelstvo', 0, '2020-10-12 18:24:19', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(166, 'Компьютерные услуги', 1, 'Компьютерные услуги', 41, '', 0, NULL, '', 'kompyuternie-uslugi', 0, '2020-10-12 18:24:22', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(167, 'Деловые услуги', 1, 'Деловые услуги', 42, '', 0, NULL, '', 'delovie-uslugi', 0, '2020-10-12 18:24:23', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(168, 'Уборка', 1, 'Уборка', 43, '', 0, NULL, '', 'uborka', 0, '2020-10-12 18:24:25', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(169, 'Автоуслуги', 1, 'Автоуслуги', 44, '', 0, NULL, '', 'avtouslugi', 0, '2020-10-12 18:24:27', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(170, 'Ремонт техники', 1, 'Ремонт техники', 45, '', 0, NULL, '', 'remont-tehniki', 0, '2020-10-12 18:24:28', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(171, 'Организация праздников', 1, 'Организация праздников', 46, '', 0, NULL, '', 'organizatsiya-prazdnikov', 0, '2020-10-12 18:24:30', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(172, 'Фото- и видеосъемка', 1, 'Фото- и видеосъемка', 47, '', 0, NULL, '', 'foto-i-videosemka', 0, '2020-10-12 18:24:32', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(173, 'Изготовление на заказ', 1, 'Изготовление на заказ', 48, '', 0, NULL, '', 'izgotovlenie-na-zakaz', 0, '2020-10-12 18:24:34', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(174, 'Продукты питания', 1, 'Продукты питания', 49, '', 0, NULL, '', 'produkti-pitaniya', 0, '2020-10-12 18:24:36', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(175, 'Уход за животными', 1, 'Уход за животными', 50, '', 0, NULL, '', 'uhod-za-zhivotnimi', 0, '2020-10-12 18:24:38', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(176, 'Другое', 1, 'Другое', 51, '', 0, NULL, '', 'drugoe', 0, '2020-10-12 18:24:39', 99, 1, 1, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

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
