# Xarxa d'agents per a Odoo

Aquesta xarxa de Custom Agents per a GitHub Copilot coordina desenvolupament, revisió, QA, seguretat, DevOps, Git i migracions d'Odoo Community.

## Agents

- `Odoo Orchestrator`: coordina els altres agents i el pla de treball.
- `Odoo Developer`: implementa models, vistes, informes, seguretat i proves.
- `Odoo Reviewer`: revisa riscos i regressions sense editar per defecte.
- `Odoo Migration`: analitza canvis entre versions i prepara scripts.
- `QA Odoo`: dissenya i implementa proves funcionals i de regressió.
- `Odoo DevOps`: prepara entorns Docker/Compose i Linux/systemd.
- `Odoo Git Release`: gestiona branques, merges, commits, tags i publicació.
- `Odoo Security`: audita permisos, dades sensibles i superfícies RPC.
- `Odoo Support`: ofereix suport funcional segur per a usuaris no experts.

## Instal·lació en un entorn Odoo

Des del checkout de l'entorn:

```bash
/path/to/agents/scripts/install-agent-network.sh \
  --source /path/to/agents \
  --target /path/to/odoo
```

Per consumir una revisió concreta del repositori central:

```bash
/path/to/agents/scripts/install-agent-network.sh \
  --source https://github.com/GerardCOPC/agents.git \
  --target /path/to/odoo \
  --ref main
```

El script sincronitza només `.github/agents`, crea una còpia de seguretat de la instalação anterior i no toca código Odoo. No guarda credencials.

## Perfils

Els perfils de `profiles/` descriuen diferències d'entorn i es poden ampliar per Odoo 14, 17, 19 i futures versions. La migració Odoo 14 -> 19 ha de ser analitzada per `Odoo Migration` i validada per `QA Odoo`, `Odoo Reviewer` i `Odoo Security`.

## Política Git

`Odoo Git Release` puede hacer pull, merge, commit y push según la política del entorno, pero debe detenerse ante conflictos, tests fallidos, ramas protegidas o cambios sensibles. Nunca usa force-push por defecto.

## Copilot Enterprise

Els fitxers `.github/agents/*.agent.md` són Custom Agents compartits pel repositori. Un administrador de GitHub Copilot Enterprise ha d'habilitar aquesta funcionalitat i permetre el repositori o l'organització segons la política corporativa. Quan el repositori sigui accessible, els agents amb `user-invocable: true` (valor per defecte) apareixeran al selector de Copilot; els usuaris necessitaran permisos de lectura.
