FROM python:3.12-alpine

WORKDIR /myapp

EXPOSE 8000

# Copy the dependency file first to improve Docker layer caching.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Run the application as a non-root user.
RUN addgroup --system appgroup \
    && adduser --system --ingroup appgroup appuser

COPY --chown=appuser:appgroup app.py .
COPY --chown=appuser:appgroup templates/ templates/
COPY --chown=appuser:appgroup static/ static/

USER appuser

EXPOSE 8000

CMD ["python", "app.py"]
