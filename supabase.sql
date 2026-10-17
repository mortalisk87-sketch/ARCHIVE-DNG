-- À coller dans Supabase > SQL Editor > Run
create extension if not exists pgcrypto with schema extensions;

create table public.videos (
  id bigint generated always as identity primary key,
  title text not null,
  descr text,
  url text not null,
  created_at timestamptz not null default now()
);

create table public.secrets (k text primary key, v text not null);
-- SHA-256 du mot de passe de l'écrivain (le mot de passe n'est jamais écrit ici)
insert into public.secrets values ('writer_hash','a2aead39bccb09645350d1f7b4a932a6adcf072bf97f73d192f4821e14e6e35b');

alter table public.videos enable row level security;
alter table public.secrets enable row level security;
create policy "everyone reads videos" on public.videos for select using (true);
-- aucune policy sur secrets : personne ne peut la lire depuis le site

create function public.check_pw(pw text) returns boolean
language sql security definer set search_path = '' as $$
  select encode(extensions.digest(pw,'sha256'),'hex') = (select v from public.secrets where k='writer_hash');
$$;

create function public.publish_video(pw text, t text, d text, u text) returns void
language plpgsql security definer set search_path = '' as $$
begin
  if not public.check_pw(pw) then raise exception 'bad password'; end if;
  insert into public.videos(title, descr, url) values (t, d, u);
end $$;

create function public.delete_video(pw text, vid bigint) returns void
language plpgsql security definer set search_path = '' as $$
begin
  if not public.check_pw(pw) then raise exception 'bad password'; end if;
  delete from public.videos where id = vid;
end $$;
