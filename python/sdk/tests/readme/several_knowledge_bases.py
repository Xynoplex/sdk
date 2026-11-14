from xynoplex.identifiers import ResourceId
from xynoplex.registry import XynoplexBrowser, XynoplexBrowserConfig, SessionFactory
from xynoplex.storage import SessionStorage
from xynoplex.watched import reached


async def pick_up_where_i_was(storage: SessionStorage, sessions: SessionFactory) -> None:
    config = XynoplexBrowserConfig(storage=storage, session_factory=sessions)
    async with XynoplexBrowser(config) as browser:
        for kb in browser.kbs.value:
            print(kb.label, kb.did, browser.kb_session_status(kb.id))
        # Held, the registry brings up the active knowledge base's session.
        await reached(browser.active_session, lambda session: session is not None)
        browser.add_open_resource(ResourceId("res-1"), "Notes")
        print([tab.name for tab in browser.open_resources.value])
