# OSS-EVAL-001 — batería v1 (perfil D0)

60 casos de aceptación recuperados de la batería aprobada; los nombres de componentes y referencias conceptuales no otorgan acceso a sistemas reales. Estado de campaña NOT_RUN. Todas las órdenes, identidades, repositorios de pruebas, efectos, datos y servicios deben ser sintéticos o públicos; si un caso requiere infraestructura privada, marcar BLOCKED para este entorno y derivar a laboratorio autorizado, no conectar la nube a ella.

Perfil comparativo inicial propuesto: 2 vCPU/1.5 GiB incluyendo dependencias cuando sea viable; medir recursos reales y no comparar perfiles distintos. 20 órdenes estables, 2 slots, 5 repeticiones; 3 ventanas de 30 min para finalistas. No ampliar recursos o gasto por inferencia. Reutilizar fixtures elegibles; sentinel de efectos independiente. ACK no equivale a término.

|ID|Prueba / aceptación mínima|
|---|---|
|A01|Licencia del tag y dependencias/edición; uso self-host sin obligación de pago ni funciones cerradas necesarias.|
|A02|Artefacto oficial pin/digest, SBOM o inventario y advisories; reproducibilidad y riesgos documentados.|
|A03|Instalación limpia declarativa; repetir desde cero misma versión, sin credenciales prod.|
|A04|Medir componentes, RAM/CPU/disco idle 5min y pico; todo dentro de perfil o NO_FIT.|
|A05|Exportar config/estado y restaurar en instancia limpia; equivalencia de IDs/config.|
|A06|Eliminar laboratorio y verificar cero listeners/procesos/volúmenes no previstos.|
|B01|Submit orden estable → recibo → terminal; ACK no confunde estado final.|
|B02|DAG A→B→C; B/C no arrancan antes de éxito precedente.|
|B03|Fan-out/fan-in 5 ramas; join una vez y bloquea ante error.|
|B04|20 órdenes, 2 slots; tercer trabajo queda en cola, máximo simultáneo<=2.|
|B05|Prioridad alta adelanta pendientes sin matar activos; medir starvation.|
|B06|Programación/sucesión tras fin con clave estable; reentrada no duplica schedule.|
|C01|Mismo ID/payload 10 submits paralelos: un trabajo lógico y un efecto.|
|C02|Mismo ID/payload distinto: conflicto explícito, no sobrescritura.|
|C03|Matar worker antes de efecto: recuperar pendiente sin pérdida.|
|C04|Matar worker después de efecto antes de ACK: reconciliar sentinel, cero doble efecto.|
|C05|Reiniciar motor con cola y lease: conservar IDs/estado; UNKNOWN sin retry ciego.|
|C06|Cancelar en cola y ejecución; no nuevos efectos tras cancel confirmado, preservar trazas.|
|D01|Manager asigna orden a worker con rol/habilidades; un dueño verificable.|
|D02|Dos workers compiten por misma tarea; checkout/reserva única.|
|D03|Claude/Codex o adaptadores sintéticos primero; sesión existente/reentrada sin duplicar agente.|
|D04|Revisor distinto del escritor, mismo SHA, resultado independiente.|
|D05|Agente queda bloqueado/paused/cuota: replanificar sin duplicar ni eludir.|
|D06|OpenProject ID→asignación→Paseo/worker→evidencia; un tracker autoritativo, sin altas duplicadas.|
|E01|E0/E1 trabajo interno autorizado sin prompts humanos por comando.|
|E02|Efecto externo sin grant/identidad válida: denegado antes de efecto.|
|E03|Grant caducado/revocado durante cola: denegado al iniciar.|
|E04|Proyecto/workspace/target no autorizado y crossover: denegado.|
|E05|PDP ausente/timeout/decisión indefinida: fail closed en PEP, cero efecto.|
|E06|Create/open/send caliente/steer/reemplazo/internal/schedule: verificar cada ruta; lectura/cancelación permitidas según alcance, sin bypass.|
|F01|Reserva atómica con dos consumidores; cap2 efectivo y cero sobreadmisión.|
|F02|Presión RAM/PSI/PIDs simulado o aislado: frenar nuevos trabajos; no matar activos arbitrariamente.|
|F03|Cuota proveedor agotada/429: pausa/relevo autorizado, sin retry ciego ni gasto.|
|F04|Telemetría stale/epoch distinto/censo incompleto: HOLD, no falso GREEN.|
|F05|MCP misma identidad/target: reutilización y cierre, no crossover; medir initialize/hijos.|
|F06|Sesión abandonada/close incierto: recurso no liberado hasta exit acreditado; rechazo antes de spawn si cap alcanzado.|
|G01|Persistir orden/attempt/receipt/estado y recuperar tras reinicio.|
|G02|DB desconectada: detener efectos no reconciliables, conservar UNKNOWN.|
|G03|Restaurar backup a DB aislada, comprobar conteos/IDs/recibos/hash.|
|G04|Reproyección OP/Git/worker/Ledger por ID estable, no duplicar tracker.|
|G05|Correlacionar evento, orden, agente, SHA, PR, receipt y resultado; no secretos.|
|G06|Resultado incierto reconciliado con fuente independiente, nunca fabricar PASS.|
|H01|Métricas nativas de cola, activos, errores y latencia; contrastar con sentinel.|
|H02|RAM PSS/cgroup, CPU, PSI, disco, PIDs durante carga y retorno idle.|
|H03|Logs/trace correlacionados por ID de prueba, sin SID/token/prompt sensible.|
|H04|Alertas por fallo/cuota/presión y recuperación; dedup de alertas.|
|H05|Medir p50/p95 de submit→start→terminal, throughput y consumo por orden; 5 repeticiones.|
|H06|30min finalista, 3 repeticiones, OOM0, ningún doble efecto/pérdida, cleanup; no live certification.|
|I01|Integración nativa con OpenProject sandbox: GET/ID y proyección idempotente sólo fixture.|
|I02|GitHub sandbox/local Git: un commit/PR sintético, SHA exacto, sin push real.|
|I03|Paseo/Agentgateway interfaces soportadas; no fork ni endpoint inventado; si no disponible BLOCKED.|
|I04|Cambio de motor conservando work order/receipts y adaptador mínimo; mismo fixture.|
|I05|Inventario de código propio residual, LOC/config/deps, funciones OSS sustituidas y mantenimiento.|
|I06|Rollback al baseline existente sin pérdida y sin doble ejecución.|
|J01|Canario vertical: orden→plan→ejecutar→verificar→receipt→proyección, sin efectos reales.|
|J02|Canario con fallo después de efecto y recuperación; resultado independiente.|
|J03|Canario multiproyecto aislado, cuotas y separación, revisión por segundo rol.|
|J04|Canario con deny de producción y aprobación explícita simulada; E0 continúa.|
|J05|Restauración vertical y reentrada con estado incierto; cero duplicados.|
|J06|Comparación final por familia: capacidad nativa demostrada, código retirables, coste y gate; sin selección automática.|

Estados: PASS, FAIL, BLOCKED, NOT_RUN, N/A justificado antes de ensayo. Gates eliminatorios: licencia/edición/coste, aislamiento y deny, cero efectos duplicados/pérdidas, restore, recursos y trazabilidad. Ponderación propuesta: funcionalidad 30, seguridad/recuperación 25, recursos/operación 20, reducción de código 15, integración 10. Escala 0–5 con evidencia; sin selección automática. Decisión por capacidad: REUSE/COMPOSE/ADAPT/EXTEND/BUILD/REJECT/HOLD. No declarar pruebas realizadas por publicar este documento.
