import Fastify from 'fastify';

const app = Fastify({ logger: true });

app.get('/health', async () => {
  return { status: 'ok', service: 'smm-aut' };
});

const port = parseInt(process.env.PORT || '3000', 10);
app.listen({ port, host: '0.0.0.0' }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`🚀 Server ready at ${address}`);
});