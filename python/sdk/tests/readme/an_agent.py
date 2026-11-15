from xynolog.bus import reply_channels_for
from xynolog.http import AgentToken, HttpTransport, SecretCredential, ServiceToken
from xynolog.operations import JOB_CLAIM
from xynolog.watched import reached


async def work(gateway: str, issuer: str, secret: str) -> None:
    service = ServiceToken(SecretCredential(issuer=issuer, client_id="xynolog-smelter", client_secret=secret))
    async with (
        AgentToken(gateway, service=service) as agent,
        HttpTransport(gateway, token=agent.token, refresher=agent.refresh, channels=reply_channels_for(JOB_CLAIM)) as transport,
    ):
        print(f"working as {agent.did}")  # who its work is attributed to: its account, as the gateway names it
        print(await reached(transport.state, lambda state: state == "open"))  # its stream is open, as the agent
