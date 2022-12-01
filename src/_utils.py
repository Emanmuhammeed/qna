import asyncio
import datetime
import edgedb

client = edgedb.create_async_client()


async def main():
    await client.query("""INSERT NPC {name := <str>$name,}""", name="Saif")

    await client.aclose()


asyncio.run(main())
