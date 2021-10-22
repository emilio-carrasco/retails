/* PUNTO 1 
¿Cómo obtendrías todas las ventas de un producto? */
SET @product_ = 1234;

SELECT sales.*
FROM product as p
INNER JOIN skus as sk
ON p.id = sk.product_id
INNER JOIN sales as s
ON s.sku_id = sk.id
WHERE p.id = @producto_;

/* PUNTO 2
¿Cómo encontrarías todas las tiendas de una categoría de tiendas, 
dado que en la tabla “category_type” hay un registro con name  ́store ́?*/

SET @id_cat_ = 1234;

SELECT ct.store
FROM category_type as ct
INNER JOIN category as c
ON c.type_id = ct.id 
WHERE ct.id = @id_cat_; /* asuminos que el campo 'store' existe a pesar de no estar en el diagra */

/* PUNTO 3 
¿Cómo encontrarías todas las ventas de un producto dado en una categoría de tiendas?*/

SET @categoria_ =1234;

SELECT sales.*
FROM sales as s
INNER JOIN stores as st
ON s.store_id = st.id
INNER JOIN category_type as ct
ON s.id = ct.store /*suponemos que existe campo store que no viene en el diagrama pero sí en el enunciado anterior*/
INNER JOIN category as c
ON ct.id = c.type_id
WHERE c.id = @categoria_ ;

/* PUNTO 4 
Las ventas registradas en el sistema se les puede haber aplicado algún descuento. 
Como encontrarías el valor de ese descuento */


/* ENTIENDO que lo que se refiere es que el precio y el precio residual refleje este descuento */
SELECT p.residual_price
FROM sales AS s
INNER JOIN skus as sk
ON s.sku_id = sk.id
INNER JOIN products as p
ON sk.product_id = p.id
WHERE p.price <> p.residual_price;
/*suponemos que el descuento aparecería en residual_price como un precio menor*/


/* PUNTO 5
5. Los días 13 y 14 de agosto, habrá una promoción especial en la tienda con el código 
390, y todos los productos del estilo “4.STYLO LIPSTICK” se venderán a mitad de precio. 
¿Qué comprobaciones y cambios habría que hacer para reflejar esta promoción correctamente? */

SET 
@name=390, #suponemos que este es el nombre de la promo
@value=0.5, 

@p_category='4.STYLO LIPSTICK',
@start= '2021-08-13',
@end= '2021-08-14';

INSERT INTO promotion (name, value) 
SELECT (@name, @value)
WHERE NOT EXISTS (SELECT * FROM promotion AS p WHERE p.id=@name LIMIT 1);

INSERT INTO promotion_period (promotion_id, product_category, start, end)
SELECT ((SELECT id FROM promotion WHERE promotion.name = @name), @p_category, @start, @end)
WHERE NOT EXISTS (SELECT * FROM promotion AS p WHERE p.id=@name LIMIT 1);


/* PUNTO 6
¿Cuál de estas tablas consideras que sería candidata para de-normalizar? */

/* He tenido que buscar bibliografía al respecto:

La normalización es una técnica de diseño de bases de datos que reduce la redundancia de datos 
y elimina características indeseables como anomalías de inserción, actualización y eliminación. 
El propósito de la normalización en SQL es eliminar los datos redundantes (repetitivos) y garantizar que los datos 
se almacenen de forma lógica.
*/
 
# Puede que fuese mejor icluir categorías dentro de store y de product pero no lo tengo muy claro
 
/* PUNTO 7
7. ¿Qué índices te parece que faltan en este esquema?*/


/* NOTA: sales no tiene id inequivoco de venta ya que su id primario es un DATE (ni tan solo con time stampo completo*/



