/*
===============================================================================
Objetivo de negocio: Unificación de registros históricos de 3 mercados y corrección de tipado dinámico para FCR.
Decisiones técnicas: Se implementa SAFE_CAST e IFNULL para forzar ceros matemáticos en valores nulos, evitando la distorsión de promedios en la capa de visualización (Tableau).

INSTRUCCIONES DE DESPLIEGUE:
1. Reemplace <TU_PROYECTO> con el ID de su proyecto en BigQuery.
2. Reemplace <TU_DATASET> con el nombre de su conjunto de datos.
===============================================================================
*/

SELECT 
    date_created,
    IFNULL(SAFE_CAST(contacts_n AS INT64), 0) AS contacts_n,
    IFNULL(SAFE_CAST(contacts_n_1 AS INT64), 0) AS contacts_n_1,
    IFNULL(SAFE_CAST(contacts_n_2 AS INT64), 0) AS contacts_n_2,
    IFNULL(SAFE_CAST(contacts_n_3 AS INT64), 0) AS contacts_n_3,
    IFNULL(SAFE_CAST(contacts_n_4 AS INT64), 0) AS contacts_n_4,
    IFNULL(SAFE_CAST(contacts_n_5 AS INT64), 0) AS contacts_n_5,
    IFNULL(SAFE_CAST(contacts_n_6 AS INT64), 0) AS contacts_n_6,
    IFNULL(SAFE_CAST(contacts_n_7 AS INT64), 0) AS contacts_n_7,
    new_type,
    new_market
FROM `<TU_PROYECTO>.<TU_DATASET>.Mercado_1`

UNION ALL

-- [Se repite la estructura para Mercado_2 y Mercado_3 usando los mismos placeholders]