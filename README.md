# Retails

## Python 
Jupyter notebook.

## SQL

  En la base de datos de una compañía logística retails de moda guardamos información de la venta historia de un retailer de moda.
Las ventas se registran como SKU - Tienda - Fecha. Cada producto puede tener varios SKUs asociados (tallas, variantes, etc. ).
También llevamos un registro de promociones. Para las promociones se hace uso de categorías, registrando los periodos (start, end) en los que a las ventas de una categoría de productos. (product_category_id) en una categoría de tiendas (store_category_id) se les aplica un valor de descuento (value, % descuento).
En el Anexo 1 se pueden ver las relaciones entre tablas en el esquema actual. En el Anexo 2 se pueden ver las definiciones de las tablas.
Preguntas:
1. ¿Cómo obtendrías todas las ventas de un producto?
2. ¿Cómo encontrarías todas las tiendas de una categoría de tiendas, dado que en la tabla “category_type” hay un registro con name  ́store ́?
3. ¿Cómo encontrarías todas las ventas de un producto dado en una categoría de tiendas?
4. Las ventas registradas en el sistema se les puede haber aplicado algún descuento. ¿Cómo encontrarías el valor de ese descuento?
5. Los días 13 y 14 de agosto, habrá una promoción especial en la tienda con el código 390, y todos los productos del estilo “4.STYLO LIPSTICK” se venderán a mitad de precio. ¿Qué comprobaciones y cambios habría que hacer para reflejar esta promoción correctamente?
6. ¿Cuál de estas tablas consideras que sería candidata para de-normalizar? 7. ¿Qué índices te parece que faltan en este esquema?

  Anexo 1: Relaciones entre las tablas
 
  Anexo 2: Definición de las tablas
  
			CREATE TABLE `sales` (
			  `store_id` int(11) NOT NULL,
			  `sku_id` int(11) NOT NULL,
			  `date` date NOT NULL,
			  `quantity` smallint(6) NOT NULL,
			  PRIMARY KEY (`date`,`store_id`,`sku_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
			CREATE TABLE `skus` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `product_id` int(11) NOT NULL,
			  `dress_size_id` int(11) NOT NULL,
			  `reference` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
			  PRIMARY KEY (`id`),
			  KEY `skus_dress_size_id_fk` (`dress_size_id`)
			) ENGINE=InnoDB AUTO_INCREMENT=11100 DEFAULT CHARSET=utf8
			COLLATE=utf8_unicode_ci;
			CREATE TABLE `stores` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
			  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1185 DEFAULT CHARSET=utf8
			COLLATE=utf8_unicode_ci;
			CREATE TABLE `category` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
			  `type_id` int(11) NOT NULL,
			  `tags` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
			  `expiration` date DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  KEY `category_type_id_fk` (`type_id`),
			  CONSTRAINT `category_type_id_fk` FOREIGN KEY (`type_id`) REFERENCES
			`category_type` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=13911 DEFAULT CHARSET=utf8
			COLLATE=utf8_unicode_ci;
			CREATE TABLE `category_item` (
			  `category_id` int(11) NOT NULL,
			  `item_id` int(11) NOT NULL,
			  PRIMARY KEY (`category_id`,`item_id`),
			  CONSTRAINT `category_id_fk` FOREIGN KEY (`category_id`) REFERENCES
			`category` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
			CREATE TABLE `category_type` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8
			COLLATE=utf8_unicode_ci;
			
			  CREATE TABLE `promotion` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
			  `value` double NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=50848 DEFAULT CHARSET=utf8
			COLLATE=utf8_unicode_ci;
			CREATE TABLE `promotion_period` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `promotion_id` int(11) NOT NULL,
			  `store_category_id` int(11) NOT NULL,
			  `product_category_id` int(11) NOT NULL,
			  `start` date NOT NULL,
			  `end` date NOT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `promotion_period-all-uniq`
			(`promotion_id`,`product_category_id`,`store_category_id`,`start`,`end`),
			  CONSTRAINT `promotion_period-promotion_id-fk` FOREIGN KEY
			(`promotion_id`) REFERENCES `promotion` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=21759 DEFAULT CHARSET=utf8;
