/*
===============================================================================
Objetivo de negocio: Análisis Exploratorio de Datos (EDA) en SQL para auditar la integridad de la base consolidada antes de la ingesta en Tableau.
Decisiones técnicas: Se validan duplicados exactos, consistencia categórica (mercados/tipos) y rangos temporales (Q1).

INSTRUCCIONES DE DESPLIEGUE:
1. Reemplace <TU_PROYECTO> y <TU_DATASET> con sus credenciales de entorno.
===============================================================================
*/

-- 1. Auditoría de Duplicados Exactos
SELECT 
    date_created, 
    new_market, 
    new_type, 
    contacts_n,
    COUNT(*) as repeticiones
FROM `<TU_PROYECTO>.<TU_DATASET>.tabla_informes`
GROUP BY date_created, new_market, new_type, contacts_n
HAVING COUNT(*) > 1
ORDER BY repeticiones DESC;

-- 2. Auditoría de Consistencia Categórica
SELECT new_market, COUNT(*) as volumen_llamadas
FROM `<TU_PROYECTO>.<TU_DATASET>.tabla_informes`
GROUP BY new_market
ORDER BY volumen_llamadas DESC;

SELECT new_type, COUNT(*) as volumen_llamadas
FROM `<TU_PROYECTO>.<TU_DATASET>.tabla_informes`
GROUP BY new_type
ORDER BY volumen_llamadas DESC;

-- 3. Auditoría de Rangos Temporales
SELECT 
    MIN(date_created) as primera_llamada_registrada,
    MAX(date_created) as ultima_llamada_registrada
FROM `<TU_PROYECTO>.<TU_DATASET>.tabla_informes`;