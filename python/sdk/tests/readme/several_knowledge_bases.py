from xynolog.identifiers import ResourceId
from xynolog.registry import SessionFactory, XynologBrowser, XynologBrowserConfig
from xynolog.storage import SessionStorage
from xynolog.watched import reached


async def pick_up_where_i_was(storage: SessionStorage, sessions: SessionFactory) -> None:
    config = XynologBrowserConfig(storage=storage, session_factory=sessions)
    async with XynologBrowser(config) as browser:
        for kb in browser.kbs.value:
            print(kb.label, kb.did, browser.kb_session_status(kb.id))
        # Held, the registry brings up the active knowledge base's session.
        await reached(browser.active_session, lambda session: session is not None)
        browser.add_open_resource(ResourceId("res-1"), "Notes")
        print([tab.name for tab in browser.open_resources.value])
