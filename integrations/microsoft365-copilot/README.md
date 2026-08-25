# Integració amb Microsoft 365 Copilot

## Objectiu

Publicar dos agents privats de Copilot Studio per a l'entorn Odoo 17:

- `Odoo Support Orchestrator`: analitza incidències i prepara una recomanació per al ticket.
- `Odoo Developer Orchestrator`: revisa el ticket, inspecciona el codi i coordina els agents tècnics.

Durant la fase inicial, els dos agents s'han de compartir només amb el propietari del projecte. No s'ha d'habilitar l'accés de tota l'organització fins que la validació funcional i de seguretat estigui completada.

## Delegació

| Agent | GitHub | Accions permeses | Destinataris |
| --- | --- | --- | --- |
| Support | Lectura de codi, issues i pull requests | Executar proves no destructives, analitzar errors i recomanar contingut del ticket | Només el propietari durant el pilot |
| Developer | Lectura i escriptura segons la política del repositori | Crear branques, canvis, issues i pull requests; executar validacions | Només el propietari durant el pilot |

El Support no ha de fer commits, modificar branques, tancar issues ni crear pull requests. El Developer ha de revisar el ticket abans d'editar i ha de demanar confirmació abans d'accions destructives o de publicar canvis.

## Agents especialitzats

Els fitxers `.github/agents/*.agent.md` són instruccions de GitHub Copilot i no es poden invocar directament des de Microsoft 365 Copilot. Cal exposar les capacitats mitjançant eines de Copilot Studio, Power Automate o una API intermèdia autenticada. La delegació recomanada és:

- Support: `Odoo Support` i, quan calgui, `Odoo Security`.
- Developer: `Odoo Developer`, `Odoo Reviewer`, `QA Odoo`, `Odoo DevOps`, `Odoo Git Release` i `Odoo Migration` segons l'abast.

## Connexió GitHub

Preferiu una GitHub App instal·lada només a l'organització i als repositoris necessaris. No introduïu PATs ni secrets en prompts, temes, fitxers de configuració o logs. La connexió ha d'utilitzar secrets de Power Platform/Entra i permisos mínims per agent.

## Publicació

1. Crear els dos agents en un entorn de desenvolupament de Copilot Studio.
2. Configurar les instruccions dels fitxers `support-orchestrator.md` i `developer-orchestrator.md`.
3. Afegir les accions GitHub darrere d'una connexió autenticada i amb permisos diferenciats.
4. Provar cada agent amb un compte administrador i casos anonimitzats.
5. Compartir només amb el propietari i publicar al canal de Microsoft 365 Copilot/Teams quan les proves siguin satisfactòries.
6. Exportar la solució i conservar-la sota control de versions, sense secrets.